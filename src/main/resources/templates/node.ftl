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
			<div class="row" style="margin-top: 13px;">
				<div class="panel-heading"><span class="glyphicon"/>
					<div style="background-color:#d9edf7;width: 580px">
						<#include "/common/header.ftl">
					</div>
				</div>
				<#if hasError??>
					<div id="errorMsgDiv" class="alert alert-danger alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<span id="errorMsgSpan">操作失败！</span>
					</div>
				</#if>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title"><span class="glyphicon glyphicon-refresh"/>节点状态</h3>
					</div>
					<div class="panel-body">
					<#if !node.inStandbyMode && node.started>
						<span class="running">运行中……</span><button type="button" class="btn btn-primary" onclick="nodeOperate('stop',${nid})">停止</button>
					</#if>
					<#if node.inStandbyMode || !node.started>
						<span class="stoped">停止中……</span><button type="button" class="btn btn-primary" onclick="nodeOperate('run',${nid})">启动</button>
					</#if>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-success" onclick="location.href='/'">刷新</button>
					</div>
				</div>
			</div>

			<div class="row" style="margin-top:13px;">
				<#if nodeInfo??>
					<#list nodeInfo as triggerGroup>
						<div class="row">
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
												<td>${trigger.name}</td>
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
                                                    <button type="button" class="btn btn-warning btn-xs" onclick="viewJobsOfTrigger('triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">查看任务</button>
													<#if trigger.status == 1>
														<button type="button" class="btn btn-success btn-xs" onclick="triggerOperate('resume', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">启动</button>
													<#elseif trigger.status != 1>
														<button type="button" class="btn btn-danger btn-xs" onclick="triggerOperate('pause', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">暂停</button>
													</#if>
													<button type="button" class="btn btn-warning btn-xs disabled" onclick="triggerOperate('trigger', 'triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">立即启动</button>
													&nbsp;
													<a role="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#editModal"
														onclick="remoteUrl('/scheduler/editTrigger.htm?triggerName=${trigger.name}&triggerGroup=${triggerGroup.groupName}&nid=${nid}')">编辑</a>
												</td>
											</tr>
										</#list>
									</tbody>
								</table>
							</div>
						</#list>
					</div>
				</#if>
			</div>
		</div>
		<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
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
		<#include "/common/footer.ftl">
        <script src="/components/dashboard.js"></script>
	</body>
</html>
