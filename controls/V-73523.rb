control 'V-73523' do
  title "The Server Message Block (SMB) v1 protocol must be disabled on the SMB
  client."
  desc "SMBv1 is a legacy protocol that uses the MD5 algorithm as part of SMB.
  MD5 is known to be vulnerable to a number of attacks such as collision and
  preimage attacks as well as not being FIPS compliant.

  Disabling SMBv1 support may prevent access to file or print sharing
  resources with systems or devices that only support SMBv1. File shares and
  print services hosted on Windows Server 2003 are an example, however Windows
  Server 2003 is no longer a supported operating system. Some older network
  attached devices may only support SMBv1.
  "
  impact 0.5
  tag "gtitle": 'WIN00-000180'
  tag "gid": 'V-73523'
  tag "rid": 'SV-88205r2_rule'
  tag "stig_id": 'WN12-00-000180'
  tag "fix_id": 'F-82947r1_fix'
  tag "cci": ['CCI-000381']
  tag "nist": ['CM-7 a', 'Rev_4']
  tag "documentable": false
  tag "check": "This requirement specifically applies to Windows 2012 but can
  also be used for Windows 2012 R2.

  Different methods are available to disable SMBv1 on Windows 2012 R2, if V-73805
  is configured on Windows 2012 R2, this is NA.

  If the following registry value is not configured as specified, this is a
  finding:

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10\\

  Value Name: Start

  Type: REG_DWORD
  Value: 0x00000004 (4)

  If the following registry value includes MRxSmb10, this is a finding:

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation\\

  Value Name: DependOnService

  Type: REG_MULTI_SZ
  Value: Default values after removing MRxSmb10 include the following, which are
  not a finding:
  Bowser
  MRxSmb20
  NSI"
  tag "fix": "Configure the policy value for Computer Configuration >>
  Administrative Templates >> MS Security Guide >> \"Configure SMBv1 client
  driver\" to \"Enabled\" with \"Disable driver (recommended)\" selected for
  \"Configure MrxSmb10 driver\".

  Configure the policy value for Computer Configuration >> Administrative
  Templates >> MS Security Guide >> \"Configure SMBv1 client (extra setting
  needed for pre-Win8.1/2012R2)\" to \"Enabled\" with the following three lines
  of text entered for \"Configure LanmanWorkstation Dependencies\":
  Bowser
  MRxSmb20
  NSI

  The system must be restarted for the changes to take effect.

  These policy settings requires the installation of the SecGuide custom
  templates included with the STIG package. \"SecGuide.admx\" and
  \"SecGuide.adml\" must be copied to the \\Windows\\PolicyDefinitions and
  \\Windows\\PolicyDefinitions\\en-US directories respectively."

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10') do
    it { should have_property 'Start' }
    its('Start') { should cmp == 4 }
  end

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\LanmanWorkstation') do
    it { should have_property 'DependOnService' }
    its('DependOnService') { should_not eq 'MRxSmb10' }
  end
end
