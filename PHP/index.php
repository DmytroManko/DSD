<?php
 include_once "createparamsarray.php";
 include_once "getfieldtype.php";
 include_once "filldataset.php";
 include_once "connectstring.php";

 set_time_limit (0);
 
// ����������, ����� ���� ������

$dbconn = pg_pconnect($connectstring)
    or die('Could not connect: ' . pg_last_error());

$doc = new DOMDocument('1.0','windows-1251');
$doc->loadXML($_POST["XML"]);

/*$doc->loadXML('<xml Session = "" >'.
    '<gp_Select_Master OutputType="otDataSet"/>'.
  '</xml>');*/


$Session = $doc->documentElement->getAttribute('Session');
$StoredProcNode = $doc->documentElement->firstChild;
$StoredProcName = $StoredProcNode->nodeName;
$OutputType = $StoredProcNode->getAttribute('OutputType');

$ParamName = '';
$ParamValues = array();

CreateParamsArray($StoredProcNode->childNodes, $Session, $ParamValues, $ParamName);

// ���������� SQL �������
if ($OutputType=='otMultiDataSet')
{
   pg_query('BEGIN;'); 
   $query = 'select * from '.$StoredProcName.'('.$ParamName.')';
}
else
{
   $query = 'select * from '.$StoredProcName.'('.$ParamName.')';
};

$result = pg_query_params($query, $ParamValues);

if ($result == false)
{
     $res = '<error ';
     $res .= 'ErrorMessage = "'.htmlspecialchars(pg_last_error(), ENT_COMPAT, 'WIN-1251').'"';
     $res .= ' />';
     echo 'error        '.gzcompress($res);
}
else
{
  if ($OutputType=='otResult')
  {// ����� ����������� � XML
    $res = "<Result";
    $i = 0;
    while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
        foreach ($line as $col_value) {
            $res .=  ' ' . pg_field_name($result, $i) . '="' . $col_value . '"';
            $i = $i + 1;
        }
    }
    $res .= "/>";
    echo 'Result       '.gzcompress($res);
  };

  if ($OutputType=='otBlob')
  {// ����� ����������� � XML
    $line = pg_fetch_array($result, null, PGSQL_ASSOC);
        foreach ($line as $col_value) {
            $res =  $col_value;
        }
    echo 'Result       '.gzcompress($res);
  };
  
  if ($OutputType=='otDataSet')
  {
     $res = FillDataSet($result);
     // ���������� ���������
     echo 'DataSet      '.gzcompress($res);
  };
   
  if ($OutputType=='otMultiDataSet')
  { 
    $res = '';
    $CursorsClose = '';
    $XMLStructure = '<DataSets>';
    while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) 
    {   
        // ��������� FETCH ��� ������� �������
        foreach ($line as $col_value) {
           $query = 'FETCH ALL "'.$col_value.'";';       
           $CursorsClose .= 'CLOSE "'.$col_value.'";';
        };
        $result_cursor = pg_query($query);
        $DataSetStr = FillDataSet($result_cursor);
        $res .= $DataSetStr;
        $XMLStructure .= '<DataSet length = "'.strlen($DataSetStr).'"/>';
    };
    $XMLStructure .= '</DataSets>';
    // ������� ����������
    pg_query($CursorsClose . 'COMMIT; END;');
    echo 'MultiDataSet ' . gzcompress(sprintf("%010d", strlen($XMLStructure)) . $XMLStructure . $res);
  };
  // ������� ����������
  pg_free_result($result);
};

// �������� ����������
pg_close($dbconn);
  
?>