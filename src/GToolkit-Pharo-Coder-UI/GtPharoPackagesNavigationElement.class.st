Class {
	#name : #GtPharoPackagesNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGtWithPharoPackagesNavigationViewModel',
	#classTraits : 'TGtWithPharoPackagesNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackagesNavigationElement >> initialize [
	super initialize.
	self
		withoutSelection;
		nodeType: [ :arg1 :arg2 | 
				{#package -> GtPharoPackageNavigationElement.
					#tag -> GtPharoPackageTagNavigationElement} asDictionary
					at: arg2 value viewModelName ];
		nodeStencil: [ :arg3 | arg3 new ];
		nodeDataBinder: [ :arg4 :arg5 | 
				| tmp1 |
				tmp1 := {#package -> #pharoPackageNavigationViewModel:.
						#tag -> #pharoTagNavigationViewModel:} asDictionary
						at: arg5 value viewModelName.
				arg4 perform: tmp1 with: arg5 value ]
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoPackagesNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	| tmp1 |
	tmp1 := {#package
				-> [ :arg1 | arg1 pharoTagsNavigationViewModel pharoTagNavigationViewModels ].
			#tag -> [ :arg2 | #() ]} asDictionary.
	self
		items: self pharoPackagesNavigationViewModel pharoPackageNavigationViewModels
		lazy: [ :arg3 | 
			| tmp2 |
			tmp2 := tmp1 at: arg3 viewModelName.
			tmp2 value: arg3 ]
]
