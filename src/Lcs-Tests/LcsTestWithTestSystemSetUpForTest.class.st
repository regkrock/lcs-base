"
Tests inheriting from this class have the current 'System' saved in the #setUP and it will be restored in the #tearDown phase.

Subclasses can choose to start a new test system in the setUp phase by overriding the {{gtMethod:LcsAbstractDomainTest>>#setUpTestSystem}}

Example: {{gtMethod:LcsPrototypeSystemTest>>#setupSunitSystem}}

"
Class {
	#name : #LcsTestWithTestSystemSetUpForTest,
	#superclass : #LcsAbstractDomainTest,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #running }
LcsTestWithTestSystemSetUpForTest >> domainModelTestClasses [
	^ OrderedCollection new
]

{ #category : #running }
LcsTestWithTestSystemSetUpForTest >> setUpTestSystem [
	self setupSunitSystem.
	self currentSystem notNil ifTrue: [
		self currentSystem buildSlotDefinitionsFor: self domainModelTestClasses ]
]

{ #category : #running }
LcsTestWithTestSystemSetUpForTest >> setupSunitSystem [
	"subclasses can override this method to create the system required for testing"
]
