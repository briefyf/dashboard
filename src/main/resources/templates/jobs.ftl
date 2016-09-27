<#if jobGroups??>
    <#list jobGroups.jobs as job>
    <span class="glyphicon glyphicon-cog"/>触发器组:${job.triggerGroup}
    <table class="table table-bordered table-striped" border="1">
        <thead>
        <tr>
            <th style="width:5%;">任务名</th>
            <th style="width:5%;">任务组</th>
            <th style="width:20%;">描述</th>
            <th style="width:10%;">触发器名称</th>
            <th style="width:10%;">任务实现</th>
            <th style="width:5%;">持久化</th>
            <th style="width:5%;">并发执行</th>
            <th style="width:5%;">可恢复</th>
            <th style="width:15%;">Opts</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><#--${job.jobName}-->a</td>
            <td><#--${job.jobGroupName}-->b</td>
            <td><#--${job.description}-->c</td>
            <td><#--${job.triggerName}-->d</td>
            <td><#--${job.className}-->e</td>
            <td>${job.persistJobDataAfterExecution?string('true','false')}</td>
            <td>${job.concurrentExectionDisallowed?string('true','false')}</td>
            <td>${job.durability?string('true','false')}</td>
            <td><a href="/job/trigger?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">立即触发</a>&nbsp;&nbsp;&nbsp;
                <a href="/job/stop?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">暂停</a>&nbsp;&nbsp;&nbsp;
                <a href="/job/resume?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">恢复</a>&nbsp;&nbsp;&nbsp;
                <a href="/job/pause?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">暂停</a>&nbsp;&nbsp;&nbsp;
                <a href="/job/del?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">删除</a>&nbsp;&nbsp;&nbsp;
                <a href="/job/disable?nid=${nid}&jobName=${job.jobName}&jobGroup=${job.jobGroupName}">禁用</a></td>
        </tr>
        </tbody>
    </table>
    </#list>
</#if>