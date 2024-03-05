Class {
	#name : #LcsTestSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-TestSystem'
}

{ #category : #accessing }
LcsTestSystem >> moduleClasses [
	^ OrderedCollection new
		add: LcsTest1Module;
		add: LcsTest2Module;
		yourself
]
