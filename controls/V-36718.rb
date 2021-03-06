control 'V-36718' do
  title "The Windows Remote Management (WinRM) service must not use Basic
  authentication."
  desc "Basic authentication uses plain text passwords that could be used to
  compromise a system."
  impact 0.7
  tag "gtitle": 'WINCC-000126'
  tag "gid": 'V-36718'
  tag "rid": 'SV-51755r2_rule'
  tag "stig_id": 'WN12-CC-000126'
  tag "fix_id": 'F-44830r1_fix'
  tag "cci": ['CCI-000877']
  tag "cce": ['CCE-23637-2']
  tag "nist": ['MA-4 c', 'Rev_4']
  tag "documentable": false
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding:

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service\\

  Value Name: AllowBasic

  Type: REG_DWORD
  Value: 0"
  tag "fix": "Configure the policy value for Computer Configuration ->
  Administrative Templates -> Windows Components -> Windows Remote Management
  (WinRM) -> WinRM Service -> \"Allow Basic authentication\" to \"Disabled\"."
  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WinRM\\Service') do
    it { should have_property 'AllowBasic' }
    its('AllowBasic') { should cmp == 0 }
  end
end
