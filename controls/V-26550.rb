control 'V-26550' do
  title "The system must be configured to audit Privilege Use - Sensitive
  Privilege Use failures."
  desc "Maintaining an audit trail of system activity logs can help identify
  configuration errors, troubleshoot service disruptions, and analyze compromises
  that have occurred, as well as detect attacks.  Audit logs are necessary to
  provide a trail of evidence in case the system or network is compromised.
  Collecting this data is essential for analyzing the security of information
  assets and detecting signs of suspicious and unexpected behavior.

  Sensitive Privilege Use records events related to use of sensitive
  privileges, such as \"Act as part of the operating system\" or \"Debug
  programs\".
  "
  impact 0.5
  tag "gtitle": 'Audit - Sensitive Privilege Use - Failure'
  tag "gid": 'V-26550'
  tag "rid": 'SV-52979r1_rule'
  tag "stig_id": 'WN12-AU-000102'
  tag "fix_id": 'F-45905r1_fix'
  tag "cci": ['CCI-000172', 'CCI-002234']
  tag "nist": ['AU-12 c', 'Rev_4']
  tag "nist": ['AC-6 (9)', 'Rev_4']
  tag "documentable": false
  tag "check": "Security Option \"Audit: Force audit policy subcategory
  settings (Windows Vista or later) to override audit policy category settings\"
  must be set to \"Enabled\" (V-14230) for the detailed auditing subcategories to
  be effective.

  Use the AuditPol tool to review the current Audit Policy configuration:
  -Open a Command Prompt with elevated privileges (\"Run as Administrator\").
  -Enter \"AuditPol /get /category:*\".

  Compare the AuditPol settings with the following.  If the system does not audit
  the following, this is a finding.

  Privilege Use -> Sensitive Privilege Use - Failure"
  tag "fix": "Configure the policy value for Computer Configuration -> Windows
  Settings -> Security Settings -> Advanced Audit Policy Configuration -> System
  Audit Policies -> Privilege Use -> \"Audit Sensitive Privilege Use\" with
  \"Failure\" selected."
  describe.one do
    describe audit_policy do
      its('Sensitive Privilege Use') { should eq 'Failure' }
    end
    describe audit_policy do
      its('Sensitive Privilege Use') { should eq 'Success and Failure' }
    end
  end
end
