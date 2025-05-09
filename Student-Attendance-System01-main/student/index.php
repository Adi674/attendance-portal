<?php 
include '../Includes/dbcon.php';
include '../Includes/session.php';

// Ensure the session is started before using session variables
if (!isset($_SESSION)) {
    session_start();
}

// Use prepared statements for the query to avoid SQL injection
$query = "SELECT tblclass.className, tblclassarms.classArmName, tblstudents.firstName, tblstudents.lastName, tblstudents.admissionNumber
          FROM tblstudents
          INNER JOIN tblclass ON tblclass.Id = tblstudents.classId
          INNER JOIN tblclassarms ON tblclassarms.Id = tblstudents.classArmId
          WHERE tblstudents.Id = ?";

$stmt = $conn->prepare($query);
$stmt->bind_param('i', $_SESSION['userId']); // Assuming userId is the student ID
$stmt->execute();
$rs = $stmt->get_result();

if ($rs->num_rows > 0) {
    $student = $rs->fetch_assoc();
} else {
    echo "No data found for this student.";
    exit; // Stop the script if no results are found
}

// Get current session and term
$querySession = "SELECT sessionName, termId FROM tblsessionterm WHERE isActive = 1";
$resultSession = $conn->query($querySession);
$activeSession = $resultSession->fetch_assoc();
$currentSession = $activeSession['sessionName'] ?? "Unknown";

// Get term name
if (isset($activeSession['termId'])) {
    $queryTerm = "SELECT termName FROM tblterm WHERE Id = " . $activeSession['termId'];
    $resultTerm = $conn->query($queryTerm);
    $termData = $resultTerm->fetch_assoc();
    $currentTerm = $termData['termName'] ?? "Unknown";
} else {
    $currentTerm = "Unknown";
}

// Get attendance count for current student
$queryAttendance = "SELECT COUNT(*) as totalDays FROM tblattendance 
                    WHERE admissionNo = ? AND status = 1";
$stmtAttendance = $conn->prepare($queryAttendance);
$stmtAttendance->bind_param('s', $student['admissionNumber']);
$stmtAttendance->execute();
$resultAttendance = $stmtAttendance->get_result();
$attendanceData = $resultAttendance->fetch_assoc();
$totalPresent = $attendanceData['totalDays'];

// Get absence count
$queryAbsence = "SELECT COUNT(*) as totalAbsent FROM tblattendance 
                WHERE admissionNo = ? AND status = 0";
$stmtAbsence = $conn->prepare($queryAbsence);
$stmtAbsence->bind_param('s', $student['admissionNumber']);
$stmtAbsence->execute();
$resultAbsence = $stmtAbsence->get_result();
$absenceData = $resultAbsence->fetch_assoc();
$totalAbsent = $absenceData['totalAbsent'];

// Calculate total school days (present + absent)
$totalSchoolDays = $totalPresent + $totalAbsent;

// Calculate attendance percentage
$attendancePercentage = $totalSchoolDays > 0 ? round(($totalPresent / $totalSchoolDays) * 100) : 0;
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" type="image/png" href="img/fulllogogbu-removebg-preview (1).png">
  <title>Student Dashboard</title>
  <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="css/ruang-admin.min.css" rel="stylesheet">
  <link href="custom.css" rel="stylesheet">

</head>

<body id="page-top">
  <div id="wrapper">
    <!-- Sidebar -->
    <?php include "Includes/student-sidebar.php";?>
    <!-- Sidebar -->
    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">
        <!-- TopBar -->
        <?php include "Includes/topbar.php";?>
        <!-- Topbar -->
        <!-- Container Fluid-->
        <div class="container-fluid" id="container-wrapper">
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Student Dashboard</h1>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="./">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
            </ol>
          </div>

          <!-- Student Info Row -->
          <div class="row mb-3">
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <div class="row">
                    <div class="col-md-2 text-center">
                      <i class="fas fa-user-graduate fa-4x text-primary mb-3"></i>
                    </div>
                    <div class="col-md-10">
                      <h4><?php echo htmlspecialchars($student['firstName'] . ' ' . $student['lastName']); ?></h4>
                      <p class="mb-0"><strong>Admission Number:</strong> <?php echo htmlspecialchars($student['admissionNumber']); ?></p>
                      <p class="mb-0"><strong>Class:</strong> <?php echo htmlspecialchars($student['className'] . ' - ' . $student['classArmName']); ?></p>
                      <p class="mb-0"><strong>Session:</strong> <?php echo htmlspecialchars($currentSession); ?></p>
                      <p class="mb-0"><strong>Term:</strong> <?php echo htmlspecialchars($currentTerm); ?></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Attendance Stats Row -->
          <div class="row mb-3">
            <!-- Present Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">Days Present</div>
                      <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><?php echo $totalPresent; ?></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar-check fa-2x text-success"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Absent Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">Days Absent</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $totalAbsent; ?></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar-times fa-2x text-danger"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Total School Days Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">Total School Days</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $totalSchoolDays; ?></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-info"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Attendance Percentage Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-uppercase mb-1">Attendance Rate</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $attendancePercentage; ?>%</div>
                      <div class="progress mt-2">
                        <div class="progress-bar bg-<?php echo $attendancePercentage >= 75 ? 'success' : ($attendancePercentage >= 50 ? 'warning' : 'danger'); ?>" 
                             role="progressbar" style="width: <?php echo $attendancePercentage; ?>%" 
                             aria-valuenow="<?php echo $attendancePercentage; ?>" aria-valuemin="0" aria-valuemax="100">
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-percentage fa-2x text-warning"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Recent Attendance -->
          <div class="row">
            <div class="col-lg-12">
              <div class="card mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Recent Attendance</h6>
                </div>
                <div class="table-responsive p-3">
                  <table class="table align-items-center table-flush table-hover">
                    <thead class="thead-light">
                      <tr>
                        <th>Date</th>
                        <th>Day</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php
                      $recentQuery = "SELECT dateTimeTaken, status FROM tblattendance 
                                      WHERE admissionNo = ? 
                                      ORDER BY dateTimeTaken DESC LIMIT 5";
                      $stmtRecent = $conn->prepare($recentQuery);
                      $stmtRecent->bind_param('s', $student['admissionNumber']);
                      $stmtRecent->execute();
                      $recentResult = $stmtRecent->get_result();
                      
                      if ($recentResult->num_rows > 0) {
                          while ($row = $recentResult->fetch_assoc()) {
                              $date = date('Y-m-d', strtotime($row['dateTimeTaken']));
                              $day = date('l', strtotime($row['dateTimeTaken']));
                              $status = $row['status'] == 1 ? '<span class="badge badge-success">Present</span>' : '<span class="badge badge-danger">Absent</span>';
                              
                              echo '<tr>
                                      <td>' . htmlspecialchars($date) . '</td>
                                      <td>' . htmlspecialchars($day) . '</td>
                                      <td>' . $status . '</td>
                                    </tr>';
                          }
                      } else {
                          echo '<tr><td colspan="3" class="text-center">No recent attendance records found</td></tr>';
                      }
                      ?>
                    </tbody>
                  </table>
                </div>
                <div class="card-footer text-center">
                  <a class="m-0 small text-primary card-link" href="student-attendance-custom.php">View More <i class="fas fa-chevron-right"></i></a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!---Container Fluid-->
      </div>
      <!-- Footer -->
      <?php include 'includes/footer.php';?>
      <!-- Footer -->
    </div>
  </div>

  <!-- Scroll to top -->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <script src="../vendor/jquery/jquery.min.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="js/ruang-admin.min.js"></script>
  <script src="../vendor/chart.js/Chart.min.js"></script>
  <script src="js/demo/chart-area-demo.js"></script>  
</body>
</html>