Class {
	#name : #LcsModuleHierarchyError,
	#superclass : #LcsError,
	#instVars : [
		'moduleClassName'
	],
	#category : #'LcsBase-Error'
}

{ #category : #'instance creation' }
LcsModuleHierarchyError class >> signalModuleRecursingToItself: moduleName [ 
	self new
		moduleName: moduleName;
		signalModuleRecursingToItself 
]

{ #category : #'instance creation' }
LcsModuleHierarchyError >> moduleName [
	^ moduleClassName
]

{ #category : #accessing }
LcsModuleHierarchyError >> moduleName: aString [ 
	moduleClassName := aString
]

{ #category : #signal }
LcsModuleHierarchyError >> signalModuleRecursingToItself [
	self signal: 'Pragma #owningModule: pointing to itself in ' , self moduleName
]
