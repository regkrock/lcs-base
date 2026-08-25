Class {
	#name : 'LcsJustificationsLoader',
	#superclass : 'LcsValueObjectsLoader',
	#category : 'Lcs-SystemSupport-Data',
	#package : 'Lcs-SystemSupport',
	#tag : 'Data'
}

{ #category : 'data' }
LcsJustificationsLoader >> data [
	^ '[
	{"code":"left","description":"left","label":"left","isDefaultInstance":true},
	{"code":"right","description":"right","label":"right","isDefaultInstance":false},
	{"code":"center","description":"center","label":"center","isDefaultInstance":false}]'
]

{ #category : 'configuration' }
LcsJustificationsLoader >> targetClass [
	^ LcsJustification
]
