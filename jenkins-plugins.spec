Name:           jenkins-plugins
Version:        1.642
Release:        1%{?dist}
Summary:        Jenkins plugins

Group:          Development/Tools
License:        MIT
URL:            http://updates.jenkins-ci.org/
Source0:        %{name}.zip
BuildRoot:      %{_tmppath}/%{name}-%{version}
BuildArch:      x86_64

%description
Jenkins plugins package provides lastest plugins for Jenkins NG master.

%prep
%setup -q -c

%install
rm -rf %{buildroot}
install -d %{buildroot}%{_sharedstatedir}/jenkins/plugins/
cp -a %{name}/* %{buildroot}%{_sharedstatedir}/jenkins/plugins/

%clean
rm -rf %{buildroot}

%files
%defattr(-,jenkins,jenkins,-)
%{_sharedstatedir}/jenkins/plugins/

%changelog
* Thu Oct 20 2016 Hung Cao Hiep <hung.cao@gooddata.com> - stable-1.642
- BUILD: Build new package version stable-1.642
