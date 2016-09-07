require 'spec_helper'
require 'serverspec'

service = 'ospfd'
config  = '/etc/ospfd.conf'
user    = '_ospfd'
group   = '_ospfd'

describe file(config) do
  it { should be_file }
  #its(:content) { should match Regexp.escape('ospfd') }
  its(:content) { should match /^auth-type crypt$/ }
  its(:content) { should match /^auth-md-keyid 1$/ }
  its(:content) { should match /^redistribute static$/ }
  its(:content) { should match /^area 0.0.0.0 {\n\s+interface em0 { passive }\n}/ }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end
