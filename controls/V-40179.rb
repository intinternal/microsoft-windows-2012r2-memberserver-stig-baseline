control 'V-40179' do
  title "Permissions for Windows installation directory must conform to minimum
  requirements."
  desc "Changing the system's file and directory permissions allows the
  possibility of unauthorized and anonymous modification to the operating system
  and installed applications.

  The default permissions are adequate when the Security Option \"Network
  access: Let everyone permissions apply to anonymous users\" is set to
  \"Disabled\" (V-3377).
  "
  impact 0.5
  tag "gtitle": 'WNGE-000008'
  tag "gid": 'V-40179'
  tag "rid": 'SV-52137r3_rule'
  tag "stig_id": 'WN12-GE-000008'
  tag "fix_id": 'F-45163r1_fix'
  tag "cci": ['CCI-001499', 'CCI-002165']
  tag "nist": ['CM-5 (6)', 'Rev_4']
  tag "nist": ['AC-3 (4)', 'Rev_4']
  tag "documentable": false
  tag "check": "The default permissions are adequate when the Security Option
  \"Network access: Let everyone permissions apply to anonymous users\" is set to
  \"Disabled\" (V-3377).  If the default ACLs are maintained and the referenced
  option is set to \"Disabled\", this is not a finding.

  Verify the default permissions for the Windows installation directory (usually
  C:\\Windows).  Nonprivileged groups such as Users or Authenticated Users must
  not have greater than Read & execute permissions except where noted as
  defaults.  (Individual accounts must not be used to assign permissions.)

  Viewing in File Explorer:
  View the Properties of the folder.
  Select the \"Security\" tab, and the \"Advanced\" button.

  Default Permissions:
  \\Windows
  Type - \"Allow\" for all
  Inherited from - \"None\" for all

  Principal - Access - Applies to

  TrustedInstaller - Full control - This folder and subfolders
  SYSTEM - Modify - This folder only
  SYSTEM - Full control - Subfolders and files only
  Administrators - Modify - This folder only
  Administrators - Full control - Subfolders and files only
  Users - Read & execute - This folder, subfolders and files
  CREATOR OWNER - Full control - Subfolders and files only
  ALL APPLICATION PACKAGES - Read & execute - This folder, subfolders and files

  Alternately, use Icacls:

  Open a Command prompt (admin).
  Enter icacls followed by the directory:

  icacls c:\\windows

  The following results should be displayed:

  c:\\windows
  NT SERVICE\\TrustedInstaller:(F)
  NT SERVICE\\TrustedInstaller:(CI)(IO)(F)
  NT AUTHORITY\\SYSTEM:(M)
  NT AUTHORITY\\SYSTEM:(OI)(CI)(IO)(F)
  BUILTIN\\Administrators:(M)
  BUILTIN\\Administrators:(OI)(CI)(IO)(F)
  BUILTIN\\Users:(RX)
  BUILTIN\\Users:(OI)(CI)(IO)(GR,GE)
  CREATOR OWNER:(OI)(CI)(IO)(F)
  APPLICATION PACKAGE AUTHORITY\\ALL APPLICATION PACKAGES:(RX)
  APPLICATION PACKAGE AUTHORITY\\ALL APPLICATION PACKAGES:(OI)(CI)(IO)(GR,GE)
  Successfully processed 1 files; Failed processing 0 files"
  tag "fix": "Maintain the default file ACLs and configure the Security Option:
  \"Network access: Let everyone permissions apply to anonymous users\" to
  \"Disabled\" (V-3377).

  Default Permissions:
  Type - \"Allow\" for all
  Inherited from - \"None\" for all

  Principal - Access - Applies to

  TrustedInstaller - Full control - This folder and subfolders
  SYSTEM - Modify - This folder only
  SYSTEM - Full control - Subfolders and files only
  Administrators - Modify - This folder only
  Administrators - Full control - Subfolders and files only
  Users - Read & execute - This folder, subfolders and files
  CREATOR OWNER - Full control - Subfolders and files only
  ALL APPLICATION PACKAGES - Read & execute - This folder, subfolders and files"

   describe file("C:\\Windows") do
    it { should be_allowed('write', by_user: 'NT AUTHORITY\\SYSTEM') }
    it { should be_allowed('write', by_user: 'BUILTIN\\Administrators') }
    it { should be_allowed('modify', by_user: 'BUILTIN\\Administrators') }
    it { should be_allowed('read', by_user: 'BUILTIN\\Users') }
    it { should be_allowed('execute', by_user: 'BUILTIN\\Users') }
    it { should be_allowed('full-control', by_user: 'NT SERVICE\\TrustedInstaller') }
    it { should be_allowed('read', by_user:  'APPLICATION PACKAGE AUTHORITY\\ALL APPLICATION PACKAGES') } 
    it { should be_allowed('execute', by_user:  'APPLICATION PACKAGE AUTHORITY\\ALL APPLICATION PACKAGES') } 
  end
end
