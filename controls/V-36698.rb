control 'V-36698' do
  title 'The use of biometrics must be disabled.'
  desc  "Allowing biometrics may bypass required authentication methods.
  Biometrics may only be used as an additional authentication factor where an
  enhanced strength of identity credential is necessary or desirable.  Additional
  factors must be met per DoD policy."
  impact 0.5
  tag "gtitle": 'WINCC-000075'
  tag "gid": 'V-36698'
  tag "rid": 'SV-51739r1_rule'
  tag "stig_id": 'WN12-CC-000075'
  tag "fix_id": 'F-44814r1_fix'
  tag "cci": ['CCI-000381']
  tag "cce": ['CCE-24801-3']
  tag "nist": ['CM-7 a', 'Rev_4']
  tag "documentable": false
  tag "ia_controls": 'IAIA-1'
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding:

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SOFTWARE\\Policies\\Microsoft\\Biometrics\\

  Value Name: Enabled

  Type: REG_DWORD
  Value: 0"
  tag "fix": "Configure the policy value for Computer Configuration ->
  Administrative Templates -> Windows Components -> Biometrics -> \"Allow the use
  of biometrics\" to \"Disabled\"."
  describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Biometrics') do
    it { should have_property 'Enabled' }
    its('Enabled') { should cmp == 0 }
  end
end
