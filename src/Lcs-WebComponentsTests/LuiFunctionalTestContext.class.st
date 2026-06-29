Class {
	#name : 'LuiFunctionalTestContext',
	#superclass : 'LcsObject',
	#instVars : [
		'functionalTest',
		'unitOfWork'
	],
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'instance creatoin' }
LuiFunctionalTestContext class >> newTest: aFunctionalTest unitOfWork: aUnitOfWOrk [
	^ self new
		functionalTest: aFunctionalTest;
		unitOfWork: aUnitOfWOrk;
		yourself
]

{ #category : 'system' }
LuiFunctionalTestContext >> clearUnitOfWork [
	self unitOfWork clearUnitOfWork.
	"LcsApplicationEnvironment removeCurrentSystem.
	self unitOfWork: nil"
]

{ #category : 'accessing' }
LuiFunctionalTestContext >> functionalTest [
	^ functionalTest
]

{ #category : 'accessing' }
LuiFunctionalTestContext >> functionalTest: anObject [
	functionalTest := anObject
]

{ #category : 'accessing' }
LuiFunctionalTestContext >> system [
	^ self unitOfWork system
]

{ #category : 'accessing' }
LuiFunctionalTestContext >> unitOfWork [
	^ unitOfWork
]

{ #category : 'accessing' }
LuiFunctionalTestContext >> unitOfWork: anObject [
	unitOfWork := anObject
]
