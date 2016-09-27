<form id="editTriggerForm" class="form-horizontal" role="form" method="post">
	<input type="hidden" name="groupName" value="${trigger.groupName}">
	<input type="hidden" name="description" value="${trigger.description}">
	<input type="hidden" name="nid" value="${nid}">
    <div class="form-group">
        <label for="triggerName" class="col-sm-4 control-label">任务名：</label>
        <div class="col-sm-8">
            <input type="text" name="triggerName" value="${trigger.triggerName}">
        </div>
    </div>
    <div class="form-group">
        <label for="description" class="col-sm-4 control-label">描述：</label>
        <div class="col-sm-8">
            <input type="text" name="description" value="${trigger.description}">
        </div>
    </div>
    <div class="form-group">
    	<label for="cronExpression" class="col-sm-4 control-label">周期表达式：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" name="cronExpression" placeholder="请输入周期表达式" value="${trigger.cronExpression}">
        </div>
    </div>
</form>