Class {
	#name : #LcsApplicationObject,
	#superclass : #LcsObject,
	#traits : 'LtApplicationEnvironment',
	#classTraits : 'LtApplicationEnvironment classTrait',
	#category : #'Lcs-SystemManagement-Environment'
}

{ #category : #testing }
LcsApplicationObject class >> isDomainClass [
	^ false
]
