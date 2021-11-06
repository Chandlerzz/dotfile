use strict;
use DBI;
use Data::Dumper; 
$Data::Dumper::Terse = 1; 
$Data::Dumper::Useqq = 1; 

my $host = "10.10.9.24";         # 主机地址
my $driver = "mysql";           # 接口类型 默认为 localhost
my $database = "university";        # 数据库
my $port = 13506;
# 驱动程序对象的句柄
my $dsn = "DBI:$driver:database=$database;host=$host;port=$port";  
my $userid = "root";            # 数据库用户名
my $password = "Risen*1107";        # 数据库密码
#  
#  # 连接数据库
my $dbh = DBI->connect($dsn, $userid, $password ,{AutoCommit=>1, RaiseError=>1}) or die $DBI::errstr;
my $sth = $dbh->prepare("select * from (select programId, id from lesson where programId = 505 or programId = 506 or programId = 507) as program,(select id from employee) as employee;");   # 预处理 SQL  语句
$sth->execute();    # 执行 SQL 操作
#   
#    
#    # 循环输出所有数据
my $sth1 = $dbh->prepare("INSERT INTO lesson_employee
    (lessonId, programId, employeeId,createdAt,updatedAt, status )
    values
    (?,?,?,?,?,?)");
while ( my @row = $sth->fetchrow_array() )
{
    my @lessonEmployeeProgram = ();
    $lessonEmployeeProgram[0]=$row[0];
    $lessonEmployeeProgram[1]=$row[1];
    $lessonEmployeeProgram[2]=$row[2];
    my $random_number = int(rand(100));
    print Dumper $random_number;
    if ($random_number>98){
        $sth1->execute($lessonEmployeeProgram[1],$lessonEmployeeProgram[0],$lessonEmployeeProgram[2],"2021-05-11 08:33:06","2021-05-11 08:33:06",1) or die $DBI::errstr;
    }

}
# $dbh->commit or die $DBI::errstr;
$sth->finish();
$sth1->finish();
$dbh->disconnect();
