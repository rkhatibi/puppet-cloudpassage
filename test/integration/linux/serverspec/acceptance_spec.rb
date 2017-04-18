require 'serverspec'

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
    'Debian'      => {
      'lsbdistid' => 'Debian',
      'osfamily'  => 'Debian',
    },
    'Ubuntu'      => {
      'lsbdistid'      => 'Ubuntu',
      'lsbdistrelease' => '14.04',
      'osfamily'       => 'Debian',
    },
    'RedHat'     => {
      'osfamily' => 'RedHat',
    },
    'CentOS'     => {
      'osfamily' => 'RedHat',
    },
    'Windows'    => {
      'kernel'   => 'windows',
      'osfamily' => 'windows',
    },
  }

  platforms.each_pair do |os, facts|
    service_name = os == 'Windows' ? 'cphalo' : 'cphalod'

    describe "on #{os}" do
      let(:facts) {{ :operatingsystem => os }.merge(facts) }

      # it { should contain_class('cloudpassage::install').that_notifies('Class[cloudpassage::config]') }
      # it { should contain_class('cloudpassage::config').that_notifies('Class[cloudpassage::service]') }
      # it { should contain_class('cloudpassage::service') }

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
              ],
              "source"          => "#{destination_dir}/#{package_file}",
            )
          }
        else
          it { should contain_package('cphalo').with_ensure('present') }
        end
      end

  #     describe 'cloudpassage::config' do
  #       if os != 'Windows'
  #         it {
  #           should contain_exec('initialize cloudpassage').with(
  #             "command"     => "/opt/cloudpassage/bin/configure --agent-key=#{agent_key} --read-only=#{audit_mode} --tag=#{tag} --server-label=#{server_label}",
  #             "refreshonly" => "true"
  #           )
  #         }
  #       end
  #     end

  #     describe 'cloudpassage::service' do
  #       it { should contain_service(service_name)
  #         .with(
  #           "enable" => true,
  #           "ensure" => true,
  #         )
  #       }
  #     end
  #   end
  # end

  # describe 'configuring repositories' do
  #   platforms.select { |k, v| v['osfamily'] == 'RedHat'}.each_pair do |os, facts|
  #     describe "on the RedHat like platform #{os}" do
  #       let(:facts) {{ :operatingsystem => os }.merge(facts) }

  #       it {
  #         should contain_yumrepo('cloudpassage').with(
  #           'descr'    => 'CloudPassage production',
  #           'baseurl'  => "http://packages.cloudpassage.com/redhat/\$basearch",
  #           'gpgcheck' => 1,
  #           'gpgkey'   => 'https://packages.cloudpassage.com/cloudpassage.packages.key'
  #         )
  #       }
  #     end
  #   end

  #   platforms.select { |k, v| v['osfamily'] == 'Debian'}.each_pair do |os, facts|
  #     describe "on the Debian like platform #{os}" do
  #       let(:facts) {{ :operatingsystem => os }.merge(facts) }

  #       it {
  #         should contain_apt__source('cloudpassage').with(
  #           'ensure'   => 'present',
  #           'key'      => {
  #             'source' => 'https://packages.cloudpassage.com/cloudpassage.packages.key',
  #             'id'     => '29AF0E02ACF0366976105511013FE82585F4BB98',
  #           },
  #           'location' => 'http://packages.cloudpassage.com/debian',
  #           'release'  => 'debian',
  #           'repos'    => 'main',
  #         )
  #       }
  #     end
  #   end
  # end

  # describe "uninstalling halo" do
  #   let(:params) do
  #     default_params.merge(
  #       package_ensure: "absent",
  #       repo_ensure:    "absent",
  #       service_enable: false,
  #       service_ensure: false
  #     )
  #   end

  #   it { should_not contain_class('cloudpassage::config') }

  #   context "when on windows" do
  #     destination_dir = "c:/tmp"
  #     package_file    = "cphalo-3.7.8-win64.exe"

  #     let(:facts) do
  #       { kernel: 'windows' }
  #     end

  #     it { should_not contain_download_file("Get cphalo.exe") }

  #     it { should contain_package('CloudPassage Halo')
  #       .with(
  #         "ensure"            => "absent",
  #         "install_options"   => [
  #           "/S",
  #           "/agent-key=#{agent_key}",
  #           "/tag=#{tag}",
  #           "/read-only=#{audit_mode}",
  #         ],
  #         "source"            => "#{destination_dir}/#{package_file}",
  #         "uninstall_options" => ['/S'],
  #       )
  #     }

  #     it { should contain_service("cphalo")
  #       .with(
  #         "enable" => false,
  #         "ensure" => false,
  #       )
  #     }
  #   end

  #   context "when on Linux" do
  #     let(:facts) do
  #       { kernel: 'Linux' }
  #     end

  #     it { should contain_package("cphalo").with_ensure("absent") }

  #     it { should contain_service("cphalod")
  #       .with(
  #         "enable" => false,
  #         "ensure" => false,
  #       )
  #     }
  #   end
  # end

  # describe "invalid params" do
  #   context "when on Linux" do
  #     let(:facts) do
  #       { kernel: 'Linux' }
  #     end

  #     context "when the 'manage_repos' param is invalid" do
  #       let(:params) do
  #         default_params.merge(manage_repos: "true")
  #       end

  #       it { should_not compile }
  #     end

  #     context "when the 'repo_ensure' param is invalid" do
  #       let(:params) do
  #         default_params.merge(repo_ensure: 123)
  #       end

  #       it { should_not compile }
  #     end
  #   end

  #   context "when on windows" do
  #     let(:facts) do
  #       { kernel: 'windows' }
  #     end

  #     context "when the 'destination_dir' param is invalid" do
  #       let(:params) do
  #         default_params.merge(destination_dir: "invalid absolute path")
  #       end

  #       it { should_not compile }
  #     end

  #     context "when the 'package_file' param is invalid" do
  #       let(:params) do
  #         default_params.merge(package_file: 123)
  #       end

  #       it { should_not compile }
  #     end

  #     context "when the 'package_url' param is invalid" do
  #       let(:params) do
  #         default_params.merge(package_url: 123)
  #       end

  #       it { should_not compile }
  #     end
  #   end

  #   context "when the 'agent_key' param is invalid" do
  #     let(:params) do
  #       default_params.merge(agent_key: 123)
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'audit_mode' param is invalid" do
  #     let(:params) do
  #       default_params.merge(audit_mode: "false")
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'package_ensure' param is invalid" do
  #     let(:params) do
  #       default_params.merge(package_ensure: 123)
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'package_name' param is invalid" do
  #     let(:params) do
  #       default_params.merge(package_name: 123)
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'service_name' param is invalid" do
  #     let(:params) do
  #       default_params.merge(service_name: 123)
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'server_label' param is invalid" do
  #     let(:params) do
  #       default_params.merge(server_label: 123)
  #     end

  #     it { should_not compile }
  #   end

  #   context "when the 'tag' param is invalid" do
  #     let(:params) do
  #       default_params.merge(tag: 123)
  #     end

  #     it { should_not compile }
  #   end
  end
end
