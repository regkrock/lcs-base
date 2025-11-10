Class {
	#name : #LcsApplicationObject,
	#superclass : #LcsObject,
	#traits : 'LtApplicationEnvironment',
	#classTraits : 'LtApplicationEnvironment classTrait',
	#instVars : [
		'targetPackageTagName'
	],
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #testing }
LcsApplicationObject class >> isDomainClass [
	^ false
]

{ #category : #accessing }
LcsApplicationObject >> targetPackageTagName [
	^ targetPackageTagName
]
