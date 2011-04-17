<?php DEFINE('INDVR', true);
#lib

include("../lib/lib.php");  #common functions

#auth check
$current_user = new user('id', $_SESSION['id']);
$current_user->checkAccessPermissions('admin');
#/auth check

class devices{
	public $info;
	public $cards;
	public $ipCameras;
	public function __construct(){
		$this->getCards();
		$this->getIpCameras();
	}
	private function getCards(){
		$cards = data::query("SELECT * FROM AvailableSources GROUP BY card_id");
		if (!$cards) { return false; } 
			else {
				foreach ($cards as $key => $card){
					$this->cards[$card['card_id']] = new card($card['card_id']);
					$this->info['total_devices'] += count($this->cards[$card['card_id']]->cameras);
				}
				
			}
	}
	private function getIpCameras(){
		$info = data::query("SELECT * FROM Devices WHERE protocol='IP'");
		foreach ($info as $key => $device){
			$this->ipCameras[$key] = new ipCamera($device['id']);
		}
		$this->info['total_devices'] += count($this->ipCameras);
	}
	public function MakeXML(){
		$this_user = new user('id', $_SESSION['id']);
		$access_list = $this_user->info['access_device_list'];
		// The \063 is a '?'. Used decimal so as not to confuse vim
		$xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" \x3f><devices>";
		$devices = array();
		if (!empty($this->cards))
		foreach($this->cards as $card_id => $card){
			$devices = array_merge($devices, $card->cameras);
		};
		$devices = array_merge($devices, $this->ipCameras);
		foreach($devices as $device){
			if (!in_array($device->info['id'], $access_list)){
				$xml .= '<device';
				$xml .= empty($device->info['id']) ? '>' : ' id="'.$device->info['id'].'">';
				foreach($device->info as $property => $value){
					if (!isset($_GET['short']) || ($property=='protocol' || $property=='device_name' || $property=='resolutionX' || $property=='resolutionY'))
						if ($property!='rtsp_password' && $property!='rtsp_username') $xml.="<$property>$value</$property>";
				};
				$xml.='</device>';
			}
		}
		$xml .='</devices>';
		header('Content-type: text/xml');
		print_r($xml);
	}
		
}

$devices = new devices;

//var_dump_pre($devices);
if (isset($_GET['XML']))
	$devices->MakeXML();
else
	include_once('../template/ajax/devices.php');

?>

