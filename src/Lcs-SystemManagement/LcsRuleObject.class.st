Class {
	#name : 'LcsRuleObject',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'description'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'defaults' }
LcsRuleObject >> defaultDescription [
	^ ''
]

{ #category : 'accessing' }
LcsRuleObject >> description [
	^ description
]

{ #category : 'accessing' }
LcsRuleObject >> description: anObject [
	description := anObject
]

{ #category : 'initialize' }
LcsRuleObject >> initialize [
	super initialize.
	self description: self defaultDescription
]
