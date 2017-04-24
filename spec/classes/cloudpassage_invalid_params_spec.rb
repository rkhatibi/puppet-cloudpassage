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

  describe "invalid params" do
    context "when on Linux" do
      let(:facts) do
        { kernel: 'Linux' }
      end

      context "when the 'manage_repos' param is invalid" do
        let(:params) do
          default_params.merge(manage_repos: "true")
        end

        it { should_not compile }
      end

      context "when the 'repo_ensure' param is invalid" do
        let(:params) do
          default_params.merge(repo_ensure: 123)
        end

        it { should_not compile }
      end
    end

    context "when on windows" do
      let(:facts) do
        { kernel: 'windows' }
      end

      context "when the 'destination_dir' param is invalid" do
        let(:params) do
          default_params.merge(destination_dir: "invalid absolute path")
        end

        it { should_not compile }
      end

      context "when the 'package_file' param is invalid" do
        let(:params) do
          default_params.merge(package_file: 123)
        end

        it { should_not compile }
      end

      context "when the 'package_url' param is invalid" do
        let(:params) do
          default_params.merge(package_url: 123)
        end

        it { should_not compile }
      end
    end

    context "when the 'agent_key' param is invalid" do
      let(:params) do
        default_params.merge(agent_key: 123)
      end

      it { should_not compile }
    end

    context "when the 'audit_mode' param is invalid" do
      let(:params) do
        default_params.merge(audit_mode: "false")
      end

      it { should_not compile }
    end

    context "when the 'package_ensure' param is invalid" do
      let(:params) do
        default_params.merge(package_ensure: 123)
      end

      it { should_not compile }
    end

    context "when the 'package_name' param is invalid" do
      let(:params) do
        default_params.merge(package_name: 123)
      end

      it { should_not compile }
    end

    context "when the 'service_name' param is invalid" do
      let(:params) do
        default_params.merge(service_name: 123)
      end

      it { should_not compile }
    end

    context "when the 'server_label' param is invalid" do
      let(:params) do
        default_params.merge(server_label: 123)
      end

      it { should_not compile }
    end

    context "when the 'tag' param is invalid" do
      let(:params) do
        default_params.merge(tag: 123)
      end

      it { should_not compile }
    end
  end
end