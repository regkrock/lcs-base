Class {
	#name : #LcsSystemActiveStatus,
	#superclass : #LcsBaseSystemStatus,
	#category : #'Lcs-DomainBase'
}

{ #category : #testing }
LcsSystemActiveStatus >> isInActiveStatus [
	^ true
]

{ #category : #accessing }
LcsSystemActiveStatus >> statusName [
	^ 'Active' translated
]

{ #category : #api }
LcsSystemActiveStatus >> suspendSystem [
	self parent _suspendSystem 
]

{ #category : #accessing }
LcsSystemActiveStatus >> toggleActionButtonLabel [
	^ 'Suspend '
]

{ #category : #accessing }
LcsSystemActiveStatus >> toggleStatus [
	^ self suspendSystem
]
