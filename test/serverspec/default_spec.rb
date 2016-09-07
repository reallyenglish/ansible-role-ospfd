require 'spec_helper'
require 'serverspec'

service = 'ospfd'
config  = '/etc/ospfd.conf'
user    = '_ospfd'
group   = '_ospfd'

describe file(config) do
  it { should be_file }
  #its(:content) { should match Regexp.escape('ospfd') }
  its(:content) { should match /^password1="password1"$/ }
  its(:content) { should match /^password2="password2"$/ }
  its(:content) { should match /^auth-md 1 \$password1$/ }
  its(:content) { should match /^auth-md 2 \$password2$/ }
  its(:content) { should match /^auth-type crypt$/ }
  its(:content) { should match /^auth-md-keyid 1$/ }
  its(:content) { should match /^redistribute static$/ }
  its(:content) { should match /^area 0.0.0.0 {\n\s+interface em0 { passive }\n}/ }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

describe command('ospfctl show int') do
  its(:stdout) { should match /^em0\s+10\.0\.2\.15\/24\s+DOWN\s+-\s+unknown\s+00:00:00\s+0\s+0$/ }
end
