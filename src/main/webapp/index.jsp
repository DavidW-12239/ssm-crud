<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Employee List</title>

    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
<%-- employee edit modal--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Edit Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Employee Name</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@crud.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> Male
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> Female
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Department Name</label>
                        <div class="col-sm-4">
                            <!-- submit dept_id -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>



<%-- employee add modal--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Employee Name</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="Employee Name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@crud.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> Male
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> Female
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Department Name</label>
                        <div class="col-sm-4">
                            <!-- submit dept_id -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Submit</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<%--construct the main page--%>
<div class="container">
    <%--title--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--btton--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">ADD</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">DELETE SELECTED</button>
        </div>
    </div>

    <%--table--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>EDIT</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <%--page info--%>
    <div class="row">
        <%--paging text info--%>
        <div class="col-md-6" id="page_info_area">

        </div>

        <%--paging info--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>

    <script type="text/javascript">

        //1. directly send an ajax request to get page info after the page is loaded
        $(function () {
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn=" + pn,
                type:"get",
                success:function(result){
                    //console.log(result);
                    //1. parse and display employee data
                    build_emps_table(result);
                    //2. parse and display paging info
                    build_page_info(result);
                    //3. parse and display paging data
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result) {
            //clear the table
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps, function(index, item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == 'M' ? "Male" : "Female");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtnTd = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" EDIT");
                //self-define attr
                editBtnTd.attr("edit-id",item.empId);

                var delBtnTd = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($(""))
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" DELETE");
                //self-define attr
                delBtnTd.attr("del-id",item.empId);

                var btnTd = $("<td></td>").append(editBtnTd).append(" ").append(delBtnTd)
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table");
            });
        }

        var totalPage, currentPage; // get the total pages and the current page
        //parse and display paging info
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("Current Page: " + result.extend.pageInfo.pageNum
                + ", Total Pages: " + result.extend.pageInfo.pages
                + ", Total Records: " + result.extend.pageInfo.total);
            totalPage = result.extend.pageInfo.pages;
            currentPage = result.extend.pageInfo.pageNum;
        }

        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            var frontPageLi = $("<li></li>").append($("<a></a>").append("Front Page").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            if (result.extend.pageInfo.hasPreviousPage==false){
                frontPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }
            else{
                //click event
                frontPageLi.click(function () {
                    to_page(1);
                })
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                })
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("Last Page").attr("href","#"));
            if (result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }
            else{
                //click event
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                })
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                })
            }

            //add first and pre pages
            ul.append(frontPageLi).append(prePageLi);
            //add page 1,2,3...
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item){
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                })
                ul.append(numLi);
            });
            //add pre and last pages
            ul.append(nextPageLi).append(lastPageLi);

            //add ul into nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //clear form style and text
        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //modal popup by clicking add
        $("#emp_add_modal_btn").click(function(){
            //clear form data
            reset_form("#empAddModal form");
            //send ajax request to get dept info
            getDepts("#empAddModal select")
            
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });
        
        //get dept info and display in the select form
        function getDepts(ele) {
            //clear previous info first
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH}/depts",
                type:"Get",
                success:function (result) {
                    //console.log(result)
                    $.each(result.extend.depts, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo(ele)
                    });
                }
            });
        }

        //verify form data
        function validate_add_form(){
            //get the form data
            var empName = $("#empName_add_input").val();
            var regName = /^[a-zA-Z0-9_-]{4,16}$/;
            if (!regName.test(empName)){
                show_validate_msg("#empName_add_input", "error", "Illegal Name");
                return false;
            }
            else {
                show_validate_msg("#empName_add_input", "success", "");
            }
            var email = $("#email_add_input").val();
            var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            if (!regEmail.test(email)){
                show_validate_msg("#email_add_input", "error", "Illegal Email Address");
                return false;
            }
            else {
                show_validate_msg("#email_add_input", "success", "");
            }
            return true;
        }
        
        function show_validate_msg(element, status, msg) {
            //clear the element class
            $(element).parent().removeClass("has-success has-error");
            $(element).next("span").text("");
            if (status=="success"){
                $(element).parent().addClass("has-success");
                $(element).next("span").text(msg);
            }
            else if(status=="error"){
                $(element).parent().addClass("has-error");
                $(element).next("span").text(msg);
            }
        }

        $("#emp_save_btn").click(function () {
            //submit emp data to the database
            //verify first
            /*if(!validate_add_form()){
                return false;
            };*/
            //1.ajax validation
            if($(this).attr("ajax-va")=="error"){
                return false;
            }
            //2.send ajax request to save emp data
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    alert(result.msg);
                    //after saving emp successfully
                    if(result.code==100){
                        //1. close the window
                        $("#empAddModal").modal('hide');
                        //2. jump to the last page
                        to_page(totalPage+1);
                    }else {
                        //display failed info
                        //console.log(result);
                        if(undefined != result.extend.errorFields.email){
                            show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                        }
                        if(undefined != result.extend.errorFields.empName){
                            show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                        }
                    }
                }
            });
        });

        $("#empName_add_input").change(function () {
            //send ajax request to check if the username is available
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkRepetitive",
                data:"empName=" + empName,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#empName_add_input", "success", "Emp Name Availavle");
                        $("#emp_save_btn").attr("ajax-va", "success");
                    }else{
                        show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va", "error");
                    }
                }
            })
        })

        $(document).on("click",".delete_btn",function () {
            //popup confirm window
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");
            if (confirm("Confirm delete " + empName + "?")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //jump to current page
                        to_page(currentPage);
                    }
                })
            }
        });

        $(document).on("click",".edit_btn",function () {
            //get and display employee and dept info
            getDepts("#empUpdateModal select");
            getEmp($(this).attr("edit-id"));
            //get emp id and send to the modal
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });

        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //update btn
        $("#emp_update_btn").click(function () {
            //verify email address
            var email = $("#email_update_input").val();
            var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            if (!regEmail.test(email)){
                show_validate_msg("#email_add_input", "error", "Illegal Email Address!");
                return false;
            }
            else {
                show_validate_msg("#email_add_input", "success", "");
            }
            //send ajax request to update emp info
            //if directly send ajax request PUT, tomcat won't package the request into emp,
            //FormContentFilter needed to override the PUT method to POST method
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    alert(result.msg);
                    $("#empUpdateModal").modal('hide');
                    //jump to current page
                    to_page(currentPage);
                }
            });
        });

        //select all / dis check all
        $("#check_all").click(function () {
            $(".check_item").prop("checked",$(this).prop("checked"));
        })

        //delete selected emp
        $("#emp_delete_all_btn").click(function () {
            var empName = "";
            var del_idstr = "";
            $.each($(".check_item:checked"), function () {
                empName += $(this).parents("tr").find("td:eq(2)").text() + ",";
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            empName = empName.substring(0, empName.length-1);
            del_idstr = del_idstr.substring(0, del_idstr.length-1);
            if(confirm("Confirm delete " + empName + "?")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //jump to current page
                        to_page(currentPage);
                    }
                });
            }
        });

        /*//check_item
        $(document).on("click",".check_item",function () {
            if($(".check_item:checked").length == $(".check_item").length){
                $(".check_item").prop("checked",$(this).prop("checked"));
            }
        })*/
    </script>

</body>
</html>
