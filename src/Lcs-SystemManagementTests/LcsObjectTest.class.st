Class {
	#name : 'LcsObjectTest',
	#superclass : 'LcsTestWithNoTestSystemSetupForTest',
	#category : 'Lcs-SystemManagementTests-Tests',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Tests'
}

{ #category : 'test' }
LcsObjectTest >> testLcsObjectIsNotAnApplicationSystem [
	self assert: LcsObject new isApplicationSystem equals: false
]

{ #category : 'test' }
LcsObjectTest >> testLcsObjectNotADomainClass [
	self assert: LcsObject isDomainClass equals: false
]
