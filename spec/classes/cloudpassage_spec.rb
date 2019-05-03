require 'spec_helper'

describe 'cloudpassage' do
  agent_key    = "dummykey"
  audit_mode   = false
  server_label = "dummylabel"
  tag         = "dummytag"

  default_params = {
    :agent_key    => agent_key,
    :audit_mode   => audit_mode,
    :server_label => server_label,
    :tag         => tag,
  }

  let(:params) { default_params }

  platforms = {
    # 'Debian'      => {
    #   'lsbdistid' => 'Debian',
    #   'os' => {
    #     'family'  => 'Debian'
    #     }
    # },
    # 'Ubuntu'      => {
    #   'lsbdistid'      => 'Ubuntu',
    #   'lsbdistrelease' => '14.04',
    #   'osfamily'       => 'Debian',
    # },
    'RedHat'     => {
      'os' => {
        'family' => 'RedHat',
      }
    },
    'CentOS'     => {
      'os' => {
        'family' => 'RedHat',
      }
    },
    'Windows'    => {
      'kernel'   => 'windows',
      'os' => {
        'family' => 'windows',
      }
    },
  }

  platforms.each_pair do |os, facts|
    service_name = os == 'Windows' ? 'cphalo' : 'cphalod'

    describe "on #{os}" do
      let(:facts) {{ :operatingsystem => os }.merge(facts) }
      it { should contain_class('cloudpassage::install').that_notifies('Class[cloudpassage::config]') }
      it { should contain_class('cloudpassage::service') }

      describe 'cloudpassage::install' do
        if os == 'Windows'
          destination_dir = "c:/tmp"
          package_file    = "cphalo-3.9.7-win64.exe"
          package_url     = "https://production.packages.cloudpassage.com/windows/#{package_file}"

          it { should contain_download_file("Get cphalo.exe")
            .with(
              "destination_directory" => destination_dir,
              "url"                   => package_url,
            )
            .that_notifies("Package[CloudPassage Halo]")
          }

          it { should contain_package('CloudPassage Halo')
            .with(
              "ensure"          => "present",
              "install_options" => [
                "/S",
                "/agent-key=#{agent_key}",
                "/tag=#{tag}",
                "/read-only=#{audit_mode}",
                "/server-label=#{server_label}",
                "/DNS=true",
                "/D="
              ],
              "source"          => "#{destination_dir}/#{package_file}",
            )
          }
        else
          it { should contain_package('cphalo').with_ensure('present') }
        end
      end

      describe 'cloudpassage::config' do
        if os != 'Windows'
          it {
            should contain_exec('initialize cloudpassage').with(
              "command"     => "/opt/cloudpassage/bin/configure --agent-key=#{agent_key} --read-only=#{audit_mode} --dns=true --tag=#{tag} --server-label=#{server_label}",
              "refreshonly" => "true"
            )
          }
        end
      end

      describe 'cloudpassage::service' do
        it { should contain_service(service_name)
          .with(
            "enable" => true,
            "ensure" => true,
          )
        }
      end
    end
  end

  describe 'configuring repositories' do
    platforms.select { |k, v| v['osfamily'] == 'RedHat'}.each_pair do |os, facts|
      describe "on the RedHat like platform #{os}" do
        let(:facts) {{ :operatingsystem => os }.merge(facts) }

        it {
          should contain_yumrepo('cloudpassage').with(
            'descr'    => 'CloudPassage production',
            'baseurl'  => "http://packages.cloudpassage.com/redhat/\$basearch",
            'gpgcheck' => 1,
            'gpgkey'   => 'https://packages.cloudpassage.com/cloudpassage.packages.key'
          )
        }
      end
    end

    platforms.select { |k, v| v['osfamily'] == 'Debian'}.each_pair do |os, facts|
      describe "on the Debian like platform #{os}" do
        let(:facts) {{ :operatingsystem => os }.merge(facts) }

        it {
          should contain_apt__source('cloudpassage').with(
            'ensure'   => 'present',
            'key'      => {
              'source' => 'https://packages.cloudpassage.com/cloudpassage.packages.key',
              'id'     => '29AF0E02ACF0366976105511013FE82585F4BB98',
            },
            'location' => 'http://packages.cloudpassage.com/debian',
            'release'  => 'debian',
            'repos'    => 'main',
          )
        }
      end
    end
  end
end
