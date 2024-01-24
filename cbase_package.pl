#!/usr/bin/perl
=pod
  Usage:
    ./cbase_package.pl
=cut

my $dest_version = "1.0.0";

my $dest_pack_name = sprintf("hotdb-engine-%s-linux-glibc2.12-x86_64.tar.gz", $dest_version);
my $dest_dir_name = sprintf("hotdb-engine-%s-linux-glibc2.12-x86_64_%s", $dest_version);
print "dest_dir_name=$dest_dir_name\n, dest_pack_name=$dest_pack_name\n";

### 清理以前可能遗留的package和dir
if (-d "bld-release") {
  chdir "bld-release";
  if (-d $dest_dir_name) {
    print "dest_dir_name=$dest_dir_name exists, try remove\n";
    system("rm -r $dest_dir_name") and die("failed to remove dir $dest_dir_name");
  }
  if (-f $dest_pack_name) {
    print "dest_pack_name=$dest_pack_name exists, try remove\n";
    system("rm $dest_pack_name") and die("failed to remove file $dest_pack_name"); 
  }
  chdir "..";
}
### call build.sh
system("./build.sh -t release -B 1") and die("failed to build check compile");

### call make package, this may call
chdir "bld-release";
print "=== calling make package to get original mysql package and package name ===\n";
my $make_output = `make package`;
my $ret = $?;
if ($ret != 0) {
  print "make package failed, ret=$ret\n";
  exit $ret;
}

my @lines = split(/\n/, $make_output);
my @output = split(' ', $lines[-1]);
my $package_name = $output[3];
my $tar_name = (split(/\//, $package_name))[-1];
print "=== make package finished tar_name=$tar_name ===\n";

### generate package
print "=== begin to do cbase package work ===\n";
my $to_rename_dir = substr($tar_name, 0, -7);
system("mkdir $dest_dir_name") and die("failed to mkdir for $dest_dir_name");
system("tar xvf $tar_name -C $dest_dir_name") and die("failed to unpack package_name=$package_name into $dest_dir_name");
system("mv $dest_dir_name/$to_rename_dir $dest_dir_name/mysql") and die("failed to rename in $dest_dir_name");
system("tar -caf $dest_dir_name.tar.xz $dest_dir_name --exclude=$dest_dir_name/mysql/mysql-test") and die("failed to package $dest_dir_name");
system("mv $dest_dir_name.tar.xz ..") and die("failed to mv $dest_dir_name");
print "=== finished to do cbase package work, cbase package_name=$dest_dir_name.tar.gz ===\n";
