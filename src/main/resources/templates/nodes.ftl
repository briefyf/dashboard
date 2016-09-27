<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<#import "/lib/main.ftl" as main>
    <title>${main.title}</title>
    <style>
        .exp{
            position:relative;
        }
        .td-opt-box{
            display: inline;
            text-align: right;
            position: static;
        }
    </style>
</head>
<body>
    <div class="container" style="width:90%;">
        <#if nodes??>
            <div >
                <div class="panel panel-default">
                    <div class="panel-heading"><span class="glyphicon"/>
                        <#include "/common/header.ftl">
                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th style="width:10%;">序号</th>
                            <th style="width:10%;">端口</th>
                            <th style="width:15%;">IP</th>
                            <th style="width:15%;">LocIP</th>
                            <th style="width:20%;">启动时间</th>
                            <th style="width:10%;">status</th>
                            <th style="width:20%;">Opt</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#list nodes as node>
                            <tr>
                                <td>${node.id}</td>
                                <td>${node.port?replace(',','')}</td>
                                <td>${node.ip}</td>
                                <td>${node.locIp}</td>
                                <td>${node.startTime?string("yyyy-MM-dd HH:mm:ss")}</td>
                                <#if  node.extInf.isStarted>
                                    <#if node.extInf.isStandby>
                                        <td>待机</td>
                                        <td>
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('run',${node.id})">运行</button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('shutdown',${node.id})">关闭</button>
                                        </td>
                                    </#if>
                                    <#if !node.extInf.isStandby>
                                        <td>运行</td>
                                        <td>
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('restart',${node.id})">重启</button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('shutdown',${node.id})">关闭</button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('standby',${node.id})">待机</button>
                                        </td>
                                    </#if>

                                    <#elseif  !node.extInf.isStarted>
                                        <td>待机</td>
                                        <td>
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('run',${node.id})">启动</button>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-primary" onclick="nodeOperate('shutdown',${node.id})">关闭</button>
                                        </td>
                                </#if>
                            </tr>
                            </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </#if>
        <#if triggerList??>
            <#list triggerList as triggerGroup>
                <div class="panel panel-default">
                    <div class="panel-heading"><span class="glyphicon glyphicon-cog"/>触发器组:${triggerGroup.groupName}</div>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th style="width:20%;">触发器名</th>
                                <th style="width:10%;">周期表达式</th>
                                <th style="width:12%;">上一次触发时间</th>
                                <th style="width:12%;">下一次触发时间</th>
                                <th style="width:5%;">状态</th>
                                <th style="width:15%;">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <#list triggerGroup.triggers as trigger>
                                <tr>
                                    <td>${trigger.name}<div class="td-opt-box"><span class="exp">&nbsp;&nbsp;&nbsp;<a class="btn-link btn-info" href="javascript:void(0)" onclick="explore('/job/list?nid=${nid}&triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}')">展开</a></span></div>
                                    <td>${trigger.cronExpression}</td>
                                    <td>
                                        <#if (trigger.previousFireTime)??>
                                            ${trigger.previousFireTime?datetime("yyyy-MM-dd HH:mm:ss")}
                                        </#if>
                                    </td>
                                    <td>
                                        <#if trigger.nextFireTime??>
                                            ${trigger.nextFireTime?datetime("yyyy-MM-dd HH:mm:ss")}
                                        </#if>
                                    </td>
                                    <td>
                                        <#if trigger.status == 0>
                                            <font color="green">正常</font>
                                        <#elseif trigger.status == 1>
                                            暂停
                                        <#elseif trigger.status == 2>
                                            完成
                                        <#elseif trigger.status == 3>
                                            <font color="red">错误</font>
                                        <#elseif trigger.status == 4>
                                            <font color="red">阻塞</font>
                                        <#elseif trigger.status == -1>
                                            无
                                        </#if>
                                    </td>
                                    <td>
                                        <#if trigger.status == 1>
                                            <button type="button" class="btn btn-success btn-xs" onclick="triggerOperate('resume', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">启动</button>
                                        <#elseif trigger.status != 1>
                                            <button type="button" class="btn btn-danger btn-xs" onclick="triggerOperate('pause', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">暂停</button>
                                        </#if>
                                    </if>
                                        <button type="button" class="btn btn-warning btn-xs" onclick="triggerOperate('trigger', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">立即启动</button>
                                        &nbsp;
                                        <a role="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#editModal"
                                           onclick="remoteUrl('/trigger/edit?triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">编辑</a>
                                    </td>
                                </tr>
                                </#list>
                            </tbody>
                        </table>
                   </div>
                </div>
            </#list>
        </#if>
    </div>
    <center><#include "/common/footer.ftl"></center>
</div>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">
                        <span class="glyphicon glyphicon-floppy-disk"/>任务编辑：
                    </h4>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveTriggerBtn" name="saveTriggerBtn" onclick="saveTrigger()">保存</button>
                </div>
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h3 class="panel-title">常用表达式，<small><a href="#" target="_blank">在线cron表达式生成器</a></small></h3>
                    </div>
                    <div class="panel-body">
                        <pre></pre>
                    </div>
                </div>
            </div>
        </div>
    </div>

   <#-- <div class="modal fade" id="jobListModal" tabindex="-1" role="dialog" aria-labelledby="myJobModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">
                        <span class="glyphicon glyphicon-floppy-disk"/>作业详情查看：
                    </h4>
                </div>
                <div class="modal-body">
                        <section class="left">
                            <p><img src="/images/0.jpeg" width="20px" height="10px"/></p>
                                <dl>

                                </dl>
                            <p class="banner"></p>
                        </section>
                        <section class="right">
                            <p class="address"><a href="/access/index.yf#map"</p>
                        </section>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"  name="saveTriggerBtn" onclick="javascript:void(0)">启动</button>
                    <button type="button" class="btn btn-warning btn-xs"  name="saveTriggerBtn" onclick="javascript:void(0)">删除</button>
                    <button type="button" class="btn btn-warning btn-xi"  name="saveTriggerBtn" onclick="javascript:void(0)">删除</button>
                    <button type="button" class="btn btn-warning btn-xs"  name="saveTriggerBtn" onclick="javascript:void(0)">删除</button>
                </div>
            </div>
        </div>
    </div>-->

    <script type="text/javascript" src="/libs/jquery.jscrollpane.min.js"></script>
    <script src="/components/dashboard.js"></script>
<script rel="script">
/*    $(function() {
        $('.modal-body').jScrollPane();
    });*/
    function explore(u){
        u += '&t=' + new Date().getTime();
        $.get(u, function (data) {
            $('#jobListModal .modal-body').html(data);
            $('#jobListModal').modal({
                show: true,
                backdrop: false
            });
        });
    }
</script>
</body>
</html>
