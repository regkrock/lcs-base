Class {
	#name : #LcsObjectTest,
	#superclass : #LcsTestWithNoTestSystemSetupForTest,
	#category : #'Lcs-SystemManagementTests-Tests'
}

{ #category : #test }
LcsObjectTest >> testCreatingSelectorNameFromAString [
	self assert: (LcsObject new selectorNameFrom: 'IsSelector') equals: #isSelector.
	self assert: (LcsObject new selectorNameFrom: 'Is Selector') equals: #isSelector 
]

{ #category : #test }
LcsObjectTest >> testLcsObjectIsNotAnApplicationSystem [
	self assert: LcsObject new isApplicationSystem equals: false
]

{ #category : #test }
LcsObjectTest >> testLcsObjectNotADomainClass [
	self assert: LcsObject isDomainClass equals: false
]
