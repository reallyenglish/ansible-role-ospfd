require 'spec_helper'

class ServiceNotReady < StandardError
end

sleep ENV['JENKINS_HOME'] ? 45 : 20

context 'after provisioning finished' do

  describe server(:r1) do
    it "can reach to the peer" do
      result = current_server.ssh_exec("ping -q -c 3 #{ server(:r2).server.address } && echo OK")
      expect(result).to match /OK/
    end
    it 'can reach to the peer\'s internal address with its own internal address' do
      result = current_server.ssh_exec("ping -q -c 3 -I 192.168.100.100 192.168.200.100 && echo OK")
      expect(result).to match /OK/
    end
  end

  describe server(:r2) do
    it "can reach to the peer" do
      result = current_server.ssh_exec("ping -q -c 3 #{ server(:r1).server.address } && echo OK")
      expect(result).to match /OK/
    end
    it 'can reach to the peer\'s internal address with its own internal address' do
      result = current_server.ssh_exec("ping -q -c 3 -I 192.168.200.100 192.168.100.100 && echo OK")
      expect(result).to match /OK/
    end
  end

end
