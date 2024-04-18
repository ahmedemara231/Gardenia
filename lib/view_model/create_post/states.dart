abstract class CreatePostStates {}

class CreatePostInitialState extends CreatePostStates {}

class CreatePostLoadingState extends CreatePostStates {}

class PercentIncrementState extends CreatePostStates {}

class CreatePostSuccessState extends CreatePostStates {}

class CreatePostErrorState extends CreatePostStates {}

class SelectImageSuccessState extends CreatePostStates {}

class CancelSelectingImageState extends CreatePostStates {}