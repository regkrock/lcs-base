Class {
	#name : #LcsUnitOfWorkTest,
	#superclass : #LcsBaseApplicationEnvironmentTest,
	#category : #'Lcs-SystemManagementTests'
}

{ #category : #test }
LcsUnitOfWorkTest >> testCreation [

	| unitOfWork |

	unitOfWork := LcsUnitOfWork new.
	self assert: unitOfWork system isNil.
	self assert: unitOfWork addedObjects isEmpty.
	self assert: unitOfWork deletedObjects isEmpty.
	self assert: unitOfWork changedObjects isEmpty.
]
