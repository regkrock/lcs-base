Class {
	#name : 'LcsModuleNotFoundError',
	#superclass : 'LcsSystemError',
	#instVars : [
		'missingModuleName'
	],
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'instance creation' }
LcsModuleNotFoundError class >> newMissing: aModuleName [
	^ self new
		initializeMissing: aModuleName;
		yourself
]

{ #category : 'gt views' }
LcsModuleNotFoundError >> gtModuleNotFoundViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView list
		title: 'Module Not Found Details';
		priority: 10;
		items: [ OrderedCollection
				with: self missingModuleName
				with: ''
				with: self messageText ];
		yourself
]

{ #category : 'instance creation' }
LcsModuleNotFoundError >> initializeMissing: aModuleName [ 
	self missingModuleName: aModuleName.
	self messageText: ('Module named ' , aModuleName asString , ' not found in current system: ' , self currentSystem printString) 
]

{ #category : 'accessing' }
LcsModuleNotFoundError >> missingModuleName [
	^ missingModuleName
]

{ #category : 'accessing' }
LcsModuleNotFoundError >> missingModuleName: anObject [
	missingModuleName := anObject
]
