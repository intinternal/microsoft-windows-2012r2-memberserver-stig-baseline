control 'V-43239' do
  title "Windows 2012 R2 must include command line data in process creation
  events."
  desc "Maintaining an audit trail of system activity logs can help identify
  configuration errors, troubleshoot service disruptions, and analyze compromises
  that have occurred, as well as detect attacks. Audit logs are necessary to
  provide a trail of evidence in case the system or network is compromised.
  Collecting this data is essential for analyzing the security of information
  assets and detecting signs of suspicious and unexpected behavior.

  Enabling \"Include command line data for process creation events\" will
  record the command line information with the process creation events in the
  log. This can provide additional detail when malware has run on a system.
  "
  impact 0.5
  tag "gtitle": 'WINCC-000139'
  tag "gid": 'V-43239'
  tag "rid": 'SV-56344r3_rule'
  tag "stig_id": 'WN12-CC-000139'
  tag "fix_id": 'F-82939r1_fix'
  tag "cci": ['CCI-000135']
  tag "nist": ['AU-3 (1)', 'Rev_4']
  tag "documentable": false
  tag "check": "This requirement is NA for the initial release of Windows 2012.
  It is applicable to Windows 2012 R2.

  Verify the registry value below. If it does not exist or is not configured as
  specified, this is a finding.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path:
  \\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Audit\\

  Value Name: ProcessCreationIncludeCmdLine_Enabled

  Value Type: REG_DWORD
  Value: 0x00000001 (1)"
  tag "fix": "Configure the policy value for Computer Configuration >>
  Administrative Templates >> System >> Audit Process Creation >> \"Include
  command line in process creation events\" to \"Enabled\"."
  if os['release'].to_i < 6.3
    impact 0.0
    describe 'Control not applicable' do
      skip 'This requirement is NA for the initial release of Windows 2012'
    end
  else
    describe registry_key('HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System\\Audit') do
      it { should have_property 'ProcessCreationIncludeCmdLine_Enabled' }
      its('ProcessCreationIncludeCmdLine_Enabled') { should cmp == 1 }
    end
  end
end
