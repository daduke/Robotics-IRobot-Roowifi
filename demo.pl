#!/usr/bin/perl -w

use strict;

use Robotics::IRobot::Roowifi;

my $robot=Robotics::IRobot::Roowifi->new('192.168.0.11', 'admin', 'roombaadmin');   #specify RooWifi IP here

$robot->init(); 

$robot->startSafeMode();
$robot->setMovementCorrectionMode("robot");

$robot->setLCD("ohai");

$robot->forward(100);

$robot->refreshSensors(); 

my $sensorState=$robot->getSensorState();

while($sensorState->{totalDistance}<60) {
    $robot->refreshSensors();
}
$robot->stop();

$robot->rotateRight(20);

$robot->refreshSensors(); 

$sensorState=$robot->getSensorState();

while($sensorState->{totalActualAngle}<1.57) {
    $robot->refreshSensors();
}

$robot->drive(100,0);

sleep 1;

$robot->stop();
$robot->close();
