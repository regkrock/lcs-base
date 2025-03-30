Class {
	#name : #LcsUndefinedSlotModelError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'domainClass'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance creation' }
LcsUndefinedSlotModelError class >> signalClassWithoutSlotModel: aClass [
	^ self new
		signalClassWithoutSlotModel: aClass
]

{ #category : #'instance creation' }
LcsUndefinedSlotModelError class >> signalSuperclassWithoutSlotModel: aClass [
	^ self new
		signalClassWithoutSlotModel: aClass
]

{ #category : #accessing }
LcsUndefinedSlotModelError >> domainClass [
	^ domainClass
]

{ #category : #accessing }
LcsUndefinedSlotModelError >> domainClass: anObject [
	domainClass := anObject
]

{ #category : #'gt views' }
LcsUndefinedSlotModelError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain';
		priority: 20;
		object: [ self domainClass ];
		view: #gtMetaFor:
]

{ #category : #'instance creation' }
LcsUndefinedSlotModelError >> signalClassWithoutSlotModel: aClass [ 
	self domainClass: aClass.
	self signal: 'No slot model defined for ' , self domainClass name
]
