Class {
	#name : #LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm,
	#superclass : #LcsMultislotPatternForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm class >> builderClass [
	^ LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob
]

{ #category : #magritte }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> buildUnknownClassDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Build Unknown Class';
		priority: 11;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder buildUnknownClass));
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #initialize }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : #magritte }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> targetDomainClassesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Target Domain Classes';
		priority: 10;
		accessor: (LcsMAPluggableAccessor 
						accessors: #(#slotModelBuilder targetDomainClasses)
						read: [ :classes | classes collect: [ :each | each name] ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asClass ] ) ]);
		default: #(  );
		classes: { String. Symbol };
		beModifiable;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (
			self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil);
		addCondition: [ :aValue | 
				aValue allSatisfy: [ :eachClassName | 
					eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed';
		blocShortcuts: [ 
			{BlShortcutWithAction new
				name: 'Browse class';
				description: 'Browses the class indicated by the editor';
				combination: BlKeyCombination primaryB;
				action: [ :anEvent | anEvent target phlow spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass gtReferences ]} ]

]
