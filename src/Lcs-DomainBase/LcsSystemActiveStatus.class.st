Class {
	#name : 'LcsSystemActiveStatus',
	#superclass : 'LcsBaseSystemStatus',
	#category : 'Lcs-DomainBase-Core',
	#package : 'Lcs-DomainBase',
	#tag : 'Core'
}

{ #category : 'testing' }
LcsSystemActiveStatus >> isInActiveStatus [
	^ true
]

{ #category : 'asking' }
LcsSystemActiveStatus >> statusName [
	^ 'Active' translated
]

{ #category : 'api' }
LcsSystemActiveStatus >> suspendSystem [
	self privateParent _suspendSystem 
]

{ #category : 'asking' }
LcsSystemActiveStatus >> toggleActionButtonLabel [
	^ 'Suspend '
]

{ #category : 'api' }
LcsSystemActiveStatus >> toggleStatus [
	^ self suspendSystem
]
