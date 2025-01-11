"
Tests inheriting from this class have the current 'System' saved in the #setUP and it will be restored in the #tearDown phase.
"
Class {
	#name : #LcsDomainTest,
	#superclass : #LcsAbstractDomainTest,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #running }
LcsDomainTest >> domainModelTestClasses [
	^ OrderedCollection new
]

{ #category : #running }
LcsDomainTest >> setUpTestSystem [
	self setupSunitSystem.
	self currentSystem notNil ifTrue: [
		self currentSystem buildSlotDefinitionsFor: self domainModelTestClasses ]
]

{ #category : #running }
LcsDomainTest >> setupSunitSystem [
	"subclasses can override this method to create the system required for testing"
]
