Class {
	#name : 'LcsProtoCode',
	#superclass : 'LcsObject',
	#instVars : [
		'code',
		'description',
		'label',
		'isDefaultInstance'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'populate' }
LcsProtoCode class >> newFromLabel: aLabel [ 
	^ self new
		label: aLabel;
		description: aLabel;
		code: (aLabel isEmpty ifTrue: [ 'unknown' ] ifFalse: [ aLabel asCamelCase asValidSelector asString]);
		isDefaultInstance: (aLabel isEmpty or: [ #('unknown' 'Unknown') includes: aLabel ]);
		yourself
]

{ #category : 'istance creation' }
LcsProtoCode class >> unknown [
	^ self new
		code: 'unknown';
		description: '';
		label: '';
		isDefaultInstance: true;
		yourself
]

{ #category : 'accessing' }
LcsProtoCode >> code [
	^ code
]

{ #category : 'accessing' }
LcsProtoCode >> code: anObject [
	code := anObject
]

{ #category : 'accessing' }
LcsProtoCode >> description [
	^ description
]

{ #category : 'accessing' }
LcsProtoCode >> description: anObject [
	description := anObject
]

{ #category : 'initialize' }
LcsProtoCode >> initialize [ 
	super initialize.
	self isDefaultInstance: false
]

{ #category : 'accessing' }
LcsProtoCode >> isDefaultInstance [
	^ isDefaultInstance
]

{ #category : 'accessing' }
LcsProtoCode >> isDefaultInstance: anObject [
	isDefaultInstance := anObject
]

{ #category : 'accessing' }
LcsProtoCode >> label [
	^ label
]

{ #category : 'accessing' }
LcsProtoCode >> label: anObject [
	label := anObject
]
