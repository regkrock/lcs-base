Class {
	#name : #LcsGlobalCollectionPatternForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName',
		'onElementCreated',
		'onReset',
		'targetClass',
		'slotModelBuilder',
		'mode',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #'instance creation' }
LcsGlobalCollectionPatternForm class >> newOn: aTargetClass [
	^ self new
		initializeOn: aTargetClass;
		yourself
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> buildUnknownClassDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Build Unknown Class';
		priority: 1;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder buildUnknownClass));
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> classNamePrefixDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Name Prefix';
		priority: 1;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classPrefix));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> classRootNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Root Name';
		priority: 1;
		accessor: (MAPluggableAccessor 
						read: [:model | model slotModelBuilder classRootName ]
						write: [:model :value | 
							model slotModelBuilder createForRootName: value.
							model slotModelBuilder buildJobSteps]);
						"accessors: #(slotModelBuilder classRootName));"
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #'magritte - support' }
LcsGlobalCollectionPatternForm >> commitSlotBuilderChangesAction [
	^ GtMagritteAction new
		beInFutureProcess;
		beWithFutureResponse;
		action: [ :aModel :aButton :aMemento :aDescription | aMemento commit ]
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn:;
		actionUpdateButton
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Raw';
		priority: 99.6;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtSlotBuilderMetaFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Meta';
		priority: 99.7;
		object: [  self slotModelBuilder ];
		view: #gtMetaFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtUMLFor: aView [
	<gtView>
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #initialize }
LcsGlobalCollectionPatternForm >> initialize [
	super initialize.
	self slotModelBuilder: LcsDomainClassAndGlobalCollectionClassBuilderJob new
]

{ #category : #initialize }
LcsGlobalCollectionPatternForm >> initializeOn: aTarget [
	| aTargetClass |
	aTargetClass := aTarget isClass ifTrue: [ aTarget ] ifFalse: [ aTarget class ].
	self targetClass: aTargetClass.
	self slotModelBuilder collectionSlotInstallationTargetClass: targetClass.
	self slotModelBuilder targetPackageName: aTargetClass package name
]

{ #category : #testing }
LcsGlobalCollectionPatternForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = LcsDomainClassAndGlobalCollectionClassBuilderJob
]

{ #category : #'magritte - support' }
LcsGlobalCollectionPatternForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Update Builder';
		action: self commitSlotBuilderChangesAction;
		beEnabledOnValidOverallStatus
]

{ #category : #'magritte - support' }
LcsGlobalCollectionPatternForm >> magritteBuildAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 30;
		label: 'Build';
		isLabelVisible: false;
		beToolbarAction;
		blocIcon: BrGlamorousVectorIcons play;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aModel slotModelBuilder execute.
					aModel  reinitialize.
					aButton phlow fireViewUpdateWish ]);
		onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription |
				aStatus isChanged
					ifTrue: [ aDescription enabled: false ]
					ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #initialize }
LcsGlobalCollectionPatternForm >> reinitialize [
	| target |
	target := self targetClass.
	self initialize.
	self initializeOn: target
]

{ #category : #accessing }
LcsGlobalCollectionPatternForm >> slotModelBuilder [
	^ slotModelBuilder
]

{ #category : #accessing }
LcsGlobalCollectionPatternForm >> slotModelBuilder: anObject [
	slotModelBuilder := anObject
]

{ #category : #accessing }
LcsGlobalCollectionPatternForm >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsGlobalCollectionPatternForm >> targetClass: anObject [
	targetClass := anObject
]
