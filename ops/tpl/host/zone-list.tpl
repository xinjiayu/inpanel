<div id="inops-host-zones-alert"></div>

<div class="incp-div-light">
<table class="table table-hover valign-middle">
  <thead><tr>
    <th>Zone</th>
  	<th>Description</th>
    <th>LAN Address</th>
    <th>WAN Address</th>
    <th>Cells</th>
    <th>Action</th>
    <th>Updated</th>
    <th></th>
  </tr></thead>
  <tbody id="inops-host-zones"></tbody>
</table>
</div>

<script id="inops-host-zones-tpl" type="text/html">
{[~it.items :v]}
<tr>
  <td class="incp-font-fixspace">
    <a href="#cell-list" onclick="inOpsHost.CellList('{[=v.meta.id]}')">{[=v.meta.id]}</a>
  </td>
  <td>{[=v.summary]}</td>
  <td>
    {[~v.lan_addrs :addr]}
    <div>{[=addr]}</div>
    {[~]}
  </td>
  <td>
    {[~v.wan_addrs :addr]}
    <div>{[=addr]}</div>
    {[~]}
  </td>
  <td>
    <button class="btn btn-sm btn-default"
      onclick="inOpsHost.CellList('{[=v.meta.id]}')">
      {[=v.cells.length]}
    </button>
  </td>
  <td>{[=inOpsHost.ActionTitle(v.phase)]}</td>
  <td>{[=l4i.MetaTimeParseFormat(v.meta.updated, "Y-m-d")]}</td>
  <td align="right">
    <button class="btn btn-sm btn-default"
      onclick="inOpsHost.ZoneSet('{[=v.meta.id]}')">
      Setting
    </button>
  </td>
</tr>
{[~]}
</script>

<script type="text/html" id="inops-cluster-zones-optools">
<li class="incp-btn incp-btn-primary">
  <a href="#" onclick="inOpsHost.ZoneSet()">
    Add a Region Zone
  </a>
</li>
</script>

