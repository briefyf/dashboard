<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<#import "/lib/main.ftl" as main>
    <title>${main.title}</title>
</head>
<body>
<div class="container" style="width:90%;">
    <div class="row page-header fixed-top">
        <div style="background-color: #c1e2b3">
        <#include "/common/header.ftl">
        </div>
        <h1>调度管理中心&nbsp;&nbsp;
            <small>当前时间：</small>
            <small id="time"></small>
        </h1>
    </div>
    <div class="row" style="margin-top: 83px;">
        <div class="row" style="margin-top: 83px;">
            集群状态显示
        </div>
        <div class="row" style="margin-top: 83px;">
            集群操作
        </div>
        <div class="row" style="margin-top: 83px;">
            集群节点展示
        </div>
    </div>
</div>
<center>
<#include "/common/footer.ftl">
</center>
</body>
</html>
