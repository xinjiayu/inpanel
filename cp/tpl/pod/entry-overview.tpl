<div id="incp-podentry-index">
  <div id="incp-podentry-overview"></div>
  <div id="incp-podentry-sidebar"></div>
</div>

<script type="text/html" id="incp-podentry-overview-oplog-tpl">
{[? it.replicas]}
{[~it.replicas :rep]}
<div class="incp-div-h-title" style="padding-top:10px">Operation Queue</div>
<div class="incp-div-light">
<table class="table table-hover" style="margin-bottom:0">
  <thead>
    <tr>
      <th>Name</th>
      <th>Status</th>
      <th>Message</th>
      <th>Updated</th>
    </tr>
  </thead>
  {[~rep.op_log.items :log]}
  <tr>
    <td>{[=log.name]}</td>
    <td>
      {[ if (log.status == "ok") { ]}
		<span class="label label-success">OK</span>
	  {[ } else if (log.status == "error" || log.status == "fatal") { ]}
		<span class="label label-danger">{[=log.status]}</span>
	  {[ } else if (log.status == "warn") { ]}
		<span class="label label-warning">{[=log.status]}</span>
      {[ } else { ]}
		<span class="label label-info">{[=log.status]}</span>
      {[ } ]}
    </td>
    <td>{[=log.message]}</td>
    <td>{[=l4i.UnixMillisecondFormat(log.updated, "Y-m-d H:i:s")]}</td>
  </tr>
  {[~]}
</table>
</div>
{[~]}
{[?]}
</script>


<script type="text/html" id="incp-podentry-overview-info-tpl">

<div class="incp-div-h-title" style="padding-top:10px">Overview</div>
<div class="incp-div-label-block-frame-inline">
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Name</div>
    <div class="value">{[=it.meta.name]}</div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Location</div>
    <div class="value">{[=it.spec.zone]} / {[=it.spec.cell]}</div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Replica</div>
    <div class="value">{[=it.operate.replica_cap]}</div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Status</div>
    <div class="value" id="incp-podentry-status-value">
    {[if (inCp.OpActionAllow(it.operate.action, inCp.OpActionRunning)) {]}
      <span class="incp-font-ok">Running</span>
    {[} else {]}
      {[=inCp.OpActionStatusTitle(it.operate.action)]}
    {[}]}
    </div>
  </div>
</div>


<div class="incp-div-h-title">Spec</div>
<div class="incp-div-label-block-frame-inline">
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Name</div>
    <div class="value">{[=it.spec.ref.name.substr("pod/spec/plan/".length)]}</div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">System Volume</div>
    <div class="value">
    {[? it.spec.volumes]}
      {[~it.spec.volumes :v]}
      {[if (v.name == "system") {]}
        {[=inCp.UtilResSizeFormat(v.size_limit)]}
      {[}]}
    {[~]}
    {[?]}
    </div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">CPU</div>
    <div class="value"td>{[=it.spec._cpu_limit]} m</div>
  </div>
  <div class="incp-div-label-block incp-div-light">
    <div class="name">Memory</div>
    <div class="value"td>{[=inCp.UtilResSizeFormat(it.spec._mem_limit)]}</div>
  </div>
</div>


{[?it.operate.replicas]}
<div class="incp-div-h-title">Replica Instances</div>
<div class="incp-div-light">
<table class="table table-hover" style="margin-bottom:0">
  <thead>
    <tr>
      <th>Rep ID</th>
      <th>Host</th>
      <th width="50%">Service Ports</th>
    </tr>
  </thead>
  {[~it.operate.replicas :rep]}
  <tr>
    <td>{[=rep.id]}</td>
    <td>{[?rep.node]}{[=rep.node]}{[??]}Scheduling{[?]}</td>
    <td>
      {[? rep.ports]}
      <table style="width:100%" class="incp-font-fixspace">
        {[~rep.ports :opv]}
        <tr>
          <td>{[=opv.name]}/TCP</td>
          <td align="right">host:{[=opv.host_port]} &nbsp;&raquo;&nbsp; pod:{[=opv.box_port]}</td>
        </tr>
        {[~]}
      </table>
	  {[?]}
    </td>
  </tr>
  {[~]}
</table>
</div>
{[?]}

{[?it.apps]}
<div class="incp-div-h-title">Applications</div>
<div class="incp-div-light">
<table class="table table-hover">
  <thead>
    <tr>
      <th>Name</th>
      <th>Spec</th>
      <th>Version</th>
      <th>Packages</th>
      <th>Executors</th>
      <th>Service Ports</th>
      <th>Updated</th>
    </tr>
  </thead>
  <tbody>
    {[~it.apps :v]}
    <tr>
      <td>{[=v.meta.name]}</td>
      <td>{[=v.spec.meta.name]}</td>
      <td>{[=v.spec.meta.version]}</td>
      <td>{[if (v.spec.packages) { ]}{[=v.spec.packages.length]}{[ } ]}</td>
      <td>{[if (v.spec.executors) { ]}{[=v.spec.executors.length]}{[ } ]}</td>
      <td>{[if (v.spec.service_ports) { ]}{[=v.spec.service_ports.length]}{[ } ]}</td>
      <td>{[=l4i.MetaTimeParseFormat(v.meta.updated, "Y-m-d")]}</td>
    </tr>
    {[~]}
  </tbody>
</table>
</div>
{[?]}

</script>

