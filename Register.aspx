<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<style>
    .alert {
        padding: 20px;
        background-color: #f44336;
        color: white;
        opacity: 1;
        transition: opacity 0.6s;
        margin-bottom: 15px;
    }

    .closebtn {
        margin-left: 15px;
        color: white;
        font-weight: bold;
        float: right;
        font-size: 22px;
        line-height: 20px;
        cursor: pointer;
        transition: 0.3s;
    }

        .closebtn:hover {
            color: black;
        }
</style>

<!DOCTYPE html>
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Register</title>
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Registration</h1>
                            </div>
                            <form class="user" id="formregistration">
                                <div class="form-group row">
                                    <div class="col-sm-12">
                                        <input type="tel" value="+62" class="form-control form-control-user" id="PhoneNumber" placeholder="Mobile Phone">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="FirstName" placeholder="First Name">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="LastName" placeholder="Last Name">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        Date Of Birth
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-4 ">
                                        <select class="custom-select" name="month" id="month">
                                            <option value="0">Month</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <select class="custom-select" name="date" id="date">
                                            <option value="0">Date</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4 mb-3 mb-sm-0">
                                        <select class="custom-select" name="year" id="year">
                                            <option value="0">Year</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row" id="gender">
                                    <div class="col-sm-5">
                                        <input type="radio" class="form-control-file1" id="Male" value="male" name="type">
                                        Male
                                    </div>
                                    <div class="col-sm-5">
                                        <input type="radio" class="form-control-file1" id="Female" value="female" name="type">
                                        Female                                       
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="email" placeholder="Email Address">
                                </div>
                                <input type="button" class="btn btn-primary btn-user btn-block" id="btnRegister" onclick="save();" value="Register">
                                <%--<a href="login.aspx" class="btn btn-primary btn-user btn-block" id="btnRegister" onclick="save();">Register
                                </a>--%>
                                <hr>
                            </form>
                            <div class="text-center">
                                <a class="btn btn-primary btn-user btn-block" href="login.aspx">Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="alert" id="alertphone" hidden>
        <span class="closebtn">&times;</span>
        <strong>Warning!</strong> Please Insert valid Indonesian phone number.
    </div>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        var year = new Date().getFullYear();
        // load years
        for (var i = 1945; i <= year; i++) $("#year").append('<option value=' + i + '>' + i + '</option>');
        // load months
        for (var i = 1; i <= 12; i++) $("#month").append('<option value=' + i + '>' + i + '</option>');
        // load days
        for (var i = 1; i <= 31; i++) $("#date").append('<option value=' + i + '>' + i + '</option>');
    });

    $(function () {
        $('#year').change(function () {
            var now = new Date();
            if ($('#year').val() == now.getFullYear()) {
                $('#month option').each(function () {
                    if ($(this).val() > (now.getMonth() + 1)) $(this).remove();
                });
            } else {
                for (var i = 1; i < 13; i++)
                    if ($("#month option[value='" + i + "']").val() == undefined)
                        $("#month").append('<option value=' + i + '>' + i + '</option>');
            }
            checkMonth();
        });
        $('#month').change(checkMonth);
    });

    function checkMonth() {
        var now = new Date();
        if ($('#year').val() == now.getFullYear() && $('#month').val() == (now.getMonth() + 1)) {
            $('#date option').each(function () {
                if ($(this).val() > now.getDate()) $(this).remove();
            });
        } else {
            var days = 31;
            var month = $('#month').val();
            if (month == 2) {
                if (($('#year').val() % 4) == 0) days = 29; // leap year
                else days = 28;
            } else if (month == 2 || month == 4 || month == 6 || month == 9 || month == 11) {
                days = 30;
            }
            for (var i = 1; i < 32; i++)
                if (i > days)
                    $("#date option[value='" + i + "']").remove();
                else if ($("#day option[value='" + i + "']").val() == undefined)
                    $("#date").append('<option value=' + i + '>' + i + '</option>');
        }
    }

    var x = $('#PhoneNumber').val().length;
    $('#PhoneNumber').on('keypress, keydown', function (event) {
        if ((event.which != 37 && (event.which != 39))
            && ((this.selectionStart < x)
            || ((this.selectionStart == x) && (event.which == 8)))) {
            return false;
        }
    });

    $("#formHotspotVoucherless").validate({//validate form
        rules: {
            phonenumber: {
                required: true,
                maxlength: 14,
                number: true
            }
        },
        messages: {
            phonenumber: {
                required: "Please insert valid Indonesian Phone Numbe",
            }
        }
    });

    function save() {
        var phone = $('#PhoneNumber').val();
        var FirstName = $('#FirstName').val();
        var LastName = $('#LastName').val();
        var email = $('#email').val();
        var regex = /((\+62[ /]*)?(\d[ /]*){10,12}\d)/;
        var regexemail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (phone != "") {
            if (regex.test(phone)) {
                alert(phone);
                return true;
            }
            else {
                alert(phone);
                //alert("Please insert valid Indonesian Phone Number");
                return false;
            }
        }
        else {
            alert("Please insert valid Indonesian Phone Number");
            return false;
        }

        if (FirstName == null | FirstName == " ") {
            alert("Please Insert First Name");
            return false;
        }

        if (LastName == null | LastName == " ") {
            alert("Please Insert Last Name");
            return false;
        }

        if (email != null | email != "") {
            if (regexemail.test(email)) {
                return true;
            }
            else {
                alert("Please insert valid email address");
                return false;
            }
        }
        else {
            alert("Please insert valid email address");
            return false;
        }

        $.ajax({
            type: "POST",
            url: 'Register.aspx/Registration',
            data: "{PhoneNumber: '" + $('#PhoneNumber').val() + "',FirstName: " + $('#FirstName').val() + "',LastName: " + $('#LastName').val() + "',BirthDate: " + $('#month').val() +
                + "',date: " + $('#date').val() + "',year: " + $('#year').val() + "',gender: " + $('#gender').val() + "',email: " + $('#email').val() + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                return true;
            },
            failure: function (response) {
                alert(response.d);
            }
        });
    }
</script>
