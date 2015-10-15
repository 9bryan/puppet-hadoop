require 'spec_helper'
describe 'hadoop' do

  context 'with defaults for all parameters' do
    it { should contain_class('hadoop') }
  end
end
