control 'V-1119' do
  title 'The system must not boot into multiple operating systems (dual-boot).'
  desc  "Allowing a system to boot into multiple operating systems
  (dual-booting) may allow security to be circumvented on a secure system."
  impact 0.5
  tag "gtitle": 'Booting into Multiple Operating Systems'
  tag "gid": 'V-1119'
  tag "rid": 'SV-52858r1_rule'
  tag "stig_id": 'WN12-GE-000010'
  tag "fix_id": 'F-45784r1_fix'
  tag "cci": ['CCI-000366']
  tag "nist": ['CM-6 b', 'Rev_4']
  tag "documentable": false
  tag "check": "Verify the local system boots directly into Windows.

  Open Control Panel.
  Select \"System\".
  Select the \"Advanced System Settings\" link.
  Select the \"Advanced\" tab.
  Click the \"Startup and Recovery\" Settings button.

  If the drop-down list box \"Default operating system:\" shows any operating
  system other than Windows Server 2012, this is a finding."
  tag "fix": "Ensure Windows Server 2012 is the only operating system installed
  for the system to boot into.  Remove alternate operating systems."
  describe command("bcdedit | Findstr description | Findstr /v /c:'Windows Boot Manager'") do
    its('stdout') { should eq "description             Windows Server 2012 R2\r\n" }
  end
  only_if { os['release'].to_i < 6.3 }
end
