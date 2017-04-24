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
    },
  }

  platforms.each_pair do |os, facts|
    service_name = os == 'Windows' ? 'cphalo' : 'cphalod'
    describe "heell" do
      facts.merge!(operatingsystem: os)
      let(:facts) { facts}
      it { should contain_class('cloudpassage::service').that_notifies('Class[cloudpassage::install]') }

      describe "uninstalling halo" do
        default_params.merge!(
            package_ensure: "absent",
            repo_ensure:    "absent",
            service_enable: false,
            service_ensure: false
          )
        let(:params) { default_params }

        it { should_not contain_class('cloudpassage::config') }
        if os == 'Windows'
          context "when on windows" do
            destination_dir = "c:/tmp"
            package_file    = "cphalo-3.9.7-win64.exe"

            it { should_not contain_download_file("Get cphalo.exe") }

            it { should contain_package('CloudPassage Halo')
              .with(
                "ensure"            => ">=absent",
                "install_options"   => [
                  "/S",
                  "/agent-key=#{agent_key}",
                  "/tag=#{tag}",
                  "/read-only=#{audit_mode}",
                  "/server-label=#{server_label}",
                  "/DNS=true",
                  "/D="
                ],
                "source"            => "#{destination_dir}/#{package_file}",
                "uninstall_options" => ['/S'],
              )
            }

            it { should contain_service("cphalo")
              .with(
                "enable" => false,
                "ensure" => false,
              )
            }
          end
        else
          context "when on Linux" do
            facts.merge!( kernel: 'Linux' )
            let(:facts) {facts}

            it { should contain_package("cphalo").with_ensure("absent") }
            it { should contain_service("cphalod")
              .with(
                "enable" => false,
                "ensure" => false,
              )
            }
          end
        end
      end
    end
  end
end
