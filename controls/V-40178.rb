control 'V-40178' do
  title "Permissions for system drive root directory (usually C:\\) must
  conform to minimum requirements."
  desc "Changing the system's file and directory permissions allows the
  possibility of unauthorized and anonymous modification to the operating system
  and installed applications.

  The default permissions are adequate when the Security Option \"Network
  access: Let everyone permissions apply to anonymous users\" is set to
  \"Disabled\" (V-3377).
  "
  impact 0.5
  tag "gtitle": 'WNGE-000006'
  tag "gid": 'V-40178'
  tag "rid": 'SV-52136r3_rule'
  tag "stig_id": 'WN12-GE-000006'
  tag "fix_id": 'F-45162r1_fix'
  tag "cci": ['CCI-002165']
  tag "nist": ['AC-3 (4)', 'Rev_4']
  tag "documentable": false
  tag "check": "The default permissions are adequate when the Security Option
  \"Network access: Let everyone permissions apply to anonymous users\" is set to
  \"Disabled\" (V-3377).  If the default ACLs are maintained and the referenced
  option is set to \"Disabled\", this is not a finding.

  Verify the default permissions for the system drive's root directory (usually
  C:\\).  Nonprivileged groups such as Users or Authenticated Users must not have
  greater than Read & execute permissions except where noted as defaults.
  (Individual accounts must not be used to assign permissions.)

  Viewing in File Explorer:
  View the Properties of system drive root directory.
  Select the \"Security\" tab, and the \"Advanced\" button.

  C:\\
  Type - \"Allow\" for all
  Inherited from - \"None\" for all

  Principal - Access - Applies to

  SYSTEM - Full control - This folder, subfolders and files
  Administrators - Full control - This folder, subfolders and files
  Users - Read & execute - This folder, subfolders and files
  Users - Create folders / append data - This folder and subfolders
  Users - Create files / write data - Subfolders only
  CREATOR OWNER - Full Control - Subfolders and files only

  Alternately, use Icacls:

  Open a Command prompt (admin).
  Enter icacls followed by the directory:

  icacls c:\\

  The following results should be displayed:

  c:\\
  NT AUTHORITY\\SYSTEM:(OI)(CI)(F)
  BUILTIN\\Administrators:(OI)(CI)(F)
  BUILTIN\\Users:(OI)(CI)(RX)
  BUILTIN\\Users:(CI)(AD)
  BUILTIN\\Users:(CI)(IO)(WD)
  CREATOR OWNER:(OI)(CI)(IO)(F)
  Successfully processed 1 files; Failed processing 0 files"
  tag "fix": "Maintain the default permissions for the system drive's root
  directory and configure the Security Option: \"Network access: Let everyone
  permissions apply to anonymous users\" to \"Disabled\" (V-3377).

  Default Permissions
  C:\\
  Type - \"Allow\" for all
  Inherited from - \"None\" for all

  Principal - Access - Applies to

  SYSTEM - Full control - This folder, subfolders and files
  Administrators - Full control - This folder, subfolders and files
  Users - Read & execute - This folder, subfolders and files
  Users - Create folders / append data - This folder and subfolders
  Users - Create files / write data - Subfolders only
  CREATOR OWNER - Full Control - Subfolders and files only"

  describe file("C:\\") do
    it { should be_allowed('full-control', by_user: 'NT AUTHORITY\\SYSTEM') }
    it { should be_allowed('full-control', by_user: 'BUILTIN\\Administrators') }
    it { should be_allowed('read', by_user: 'BUILTIN\\Users') }
    it { should be_allowed('execute', by_user: 'BUILTIN\\Users') }
    it { should be_allowed('append-data', by_user:  'BUILTIN\\Users') } 
  end
end
