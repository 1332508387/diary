<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="include/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="/res/bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="/res/plugins/validator/bootstrapValidator.min.css"/>
    <link rel="stylesheet" href="/res/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/res/plugins/bootstrap-slider/slider.css">
    <!-- 双日历插件 -->
    <link rel="stylesheet" href="${path}/res/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="${path}/res/plugins/select2/css/select2.min.css">

    <script type="text/javascript"
            src="/res/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="/js/base64.js"></script>
    <script type="text/javascript" src="/js/security.js"></script>
    <script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="/res/plugins/validator/bootstrapValidator.min.js"></script>
    <script src="/res/plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="/res/plugins/datepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="/res/plugins/bootstrap-slider/bootstrap-slider.js"></script>
    <script src="/res/plugins/bootstrap-slider/bootstrap-slider.js"></script>
    <script src="${path}/res/plugins/daterangepicker/moment.min.js"></script>
    <script src="${path}/res/plugins/daterangepicker/daterangepicker.js"></script>
    <script src="${path}/res/plugins/select2/js/select2.js"></script>
</head>
<body>
    <select class="" name="states[]" id="s" multiple="multiple" style="width: 500px;">
        <option value="0" selected>Alabama</option>
        <option value="1" selected>Wyoming</option>
    </select>
    <a id="aaa" style="cursor:  hand;">click</a>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#s').select2();
            $('#aaa').click(function () {
                $('#s').val(0);
            })
        });
    </script>
</body>
</html>