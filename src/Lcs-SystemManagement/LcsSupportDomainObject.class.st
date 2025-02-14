"
These are support classes which have a slot model but are not part of the domain model.
"
Class {
	#name : #LcsSupportDomainObject,
	#superclass : #LcsBaseDomainObject,
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'instance  creation\t' }
LcsSupportDomainObject class >> new [
	| newObject |
	newObject := self basicNew.
	newObject initialize.
	^ newObject
]

{ #category : #initialization }
LcsSupportDomainObject >> initialize [
	"Subclasses should redefine this method to perform initializations on instance creation"
]
