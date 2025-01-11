Class {
	#name : #LcsBaseClassBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'installedClass',
		'rootName',
		'newClassName',
		'targetPackageName',
		'targetSuperclassName',
		'jobSteps'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'instance  creation' }
LcsBaseClassBuilder class >> newOn: aString [ 
	^ self new
		initializeOn: aString;
		yourself
]

{ #category : #accessing }
LcsBaseClassBuilder class >> targetSuperclassName [
	^ nil
]

{ #category : #template }
LcsBaseClassBuilder >> addRefactoringTextDetailsTo: aStream [
	aStream nextPutAll: self classCreationString
]

{ #category : #template }
LcsBaseClassBuilder >> classCreationString [
	^ '<1s> subclass: #<2s>
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''<3s>'' '
			expandMacrosWith: self targetSuperclassName
			with: self newClassName
			with: self targetPackageName
]

{ #category : #uninstall }
LcsBaseClassBuilder >> clearTargetClass: aClass [
	self installedClass == aClass
		ifTrue: [ self installedClass: nil ]
]

{ #category : #refactoring }
LcsBaseClassBuilder >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #accessing }
LcsBaseClassBuilder >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView text
		title: 'Refactoring';
		priority: 1;
		text: [ self refactoringText asRopedText ]
	
]

{ #category : #initialize }
LcsBaseClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class targetSuperclassName.
	self jobSteps: (LcsCodeBuilderJobSteps newOn: self)
]

{ #category : #initialize }
LcsBaseClassBuilder >> initializeOn: aBuilder [ 
	self parent: aBuilder
]

{ #category : #build }
LcsBaseClassBuilder >> installCode [
	self addRefactoring: (RBAddClassChange definition: self classCreationString) execute.
	self installedClass: self refactorings last changeClass.
	self beCodeInstalled
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass [
	^ installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> installedClass: aClass [ 
	installedClass := aClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> jobSteps [
	^ jobSteps
]

{ #category : #accessing }
LcsBaseClassBuilder >> jobSteps: anObject [
	jobSteps := anObject
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName [
	^ newClassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> newClassName: aString [ 
	newClassName := aString
]

{ #category : #printing }
LcsBaseClassBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Create class: ';
		nextPutAll: self newClassName asString;
		nextPutAll: ' as subclass of ';
		nextPutAll: self targetSuperclassName displayString
]

{ #category : #building }
LcsBaseClassBuilder >> removeReferencesFromSubsequentSteps [
	self parent isNil ifTrue: [ ^ self ].
	self parent inStepsAfter: self removeTargetClass: self installedClass
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName [
	^ rootName
]

{ #category : #accessing }
LcsBaseClassBuilder >> rootName: aString [ 
	rootName := aString
]

{ #category : #printing }
LcsBaseClassBuilder >> stepNumber [
	^ (self parent indexOf: self) printString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetPackageName: aString [
	targetPackageName := aString
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName [
	^ targetSuperclassName
]

{ #category : #accessing }
LcsBaseClassBuilder >> targetSuperclassName: aString [
	targetSuperclassName := aString
]

{ #category : #building }
LcsBaseClassBuilder >> uninstall [
	self installedClass ifNil: [ ^ self ].
	self currentSystem removeClassFromSlotModel: self installedClass.
	self removeReferencesFromSubsequentSteps.
	self reverseRefactorings.
	self installedClass: nil
]

{ #category : #install }
LcsBaseClassBuilder >> updateSlotModel [
	self installedClass initializeSlotModel
]

{ #category : #install }
LcsBaseClassBuilder >> verifyCodeInstallation [
	self assert: self installedClass notNil description: 'Class has been created'.
	self assert: self installedClass name equals: self newClassName.
	self assert: self installedClass slotModel isNil description: 'The class has been created but not yet installed in a system'
]

{ #category : #install }
LcsBaseClassBuilder >> verifySlotModelUpdatesMadeByBuilder [
	self assert: self installedClass slotModel  notNil.
	self assert: (self currentSystem systemSlotModel hasSlotModelForClass: self installedClass)
]

{ #category : #'gt view' }
LcsBaseClassBuilder >> viewCodeButton [
	self installedClass isNil ifTrue: [ ^ BrButton new ].
	^ self viewClassButtonFor: self installedClass 
]
